
extern crate clap;
extern crate log;

use std::process::exit;

use clap::{Arg, App, ArgMatches, SubCommand};
use log::{info, trace, warn};


struct ProgramData {
    name: &'static str,
    version: &'static str,
    authors: &'static str,
    description: &'static str,
}
impl ProgramData {
    fn from_env() -> ProgramData {
        ProgramData {
            name: env!("CARGO_PKG_NAME"),
            version: env!("CARGO_PKG_VERSION"),
            authors: env!("CARGO_PKG_AUTHORS"),
            description: env!("CARGO_PKG_DESCRIPTION"),
        }
    }
}


struct ProgramConfig {
    command: String,
    verbosity: u8,
    force: bool,
}
impl ProgramConfig {
    fn from_arg_matches(arg_matches: ArgMatches) -> ProgramConfig {
        ProgramConfig {
            command: ProgramConfig::get_subcommand_or_exit(&arg_matches),
            verbosity: ProgramConfig::get_verbosity(&arg_matches),
            force: arg_matches.is_present("force"),
        }
    }

    fn get_subcommand_or_exit(arg_matches: &ArgMatches) -> String {
        match arg_matches.subcommand_name() {
            Some(s) => String::from(s),
            None => {
                eprintln!("You must specify a sub-command");
                exit(1);
            }
        }
    }

    fn get_verbosity(arg_matches: &ArgMatches) -> u8 {
        let occurrences = arg_matches.occurrences_of("verbose");
        if occurrences > 255 {
            eprintln!("We cannot be that verbose");
            exit(1)
        }
        occurrences as u8
    }
}

/// Create a new "force" ("-f") argument
///
/// This is a shared option for many of the sub-commands, so this helper
/// is here to generate an equivalent one for each.
fn new_force_arg<'a, 'b>() -> Arg<'a, 'b> {
    Arg::with_name("force")
        .short("f")
        .help(
            "overwrite existing configuration files
            with the ones from this repo"
        )
}


fn args<'a, 'b>(program_data: &'a ProgramData) -> ArgMatches<'a> {
    App::new(program_data.name)
        .version(program_data.version)
        .author(program_data.authors)
        .about(program_data.description)
        .arg(
            Arg::with_name("verbose")
                .short("v")
                .multiple(true)
        )
        .subcommand(
            SubCommand::with_name("init")
                .about("initialize the host")
                .arg(new_force_arg())
        )
        .subcommand(
            SubCommand::with_name("update")
                .about("ensure the host is up to doate")
                .arg(new_force_arg())
        )
        .get_matches()
}


fn main() {
    let program_data = ProgramData::from_env();
    let arg_matches = args(&program_data);
    let config = ProgramConfig::from_arg_matches(arg_matches);
}
