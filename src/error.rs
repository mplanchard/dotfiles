//! Common Error Handling
//!


use fern;


/// A general error enum
#[derive(Debug)]
pub enum Error {
    ConfigError(ConfigError),
}
impl From<fern::InitError> for Error {
    fn from(err: fern::InitError) -> Self {
        Self::ConfigError(ConfigError::from(err))
    }
    fn from(err: fern::InitError) -> Self {
        Self::ConfigError(ConfigError::from(err))
    }
}


/// An error that occurred during configuration parsing or application
#[derive(Debug)]
pub enum ConfigError {
    LoggingError(fern::InitError)
}
impl From<fern::InitError> for ConfigError {
    fn from(err: fern::InitError) -> Self {
        Self::LoggingError(err)
    }
}
