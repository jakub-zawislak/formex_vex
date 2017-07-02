use Mix.Config

config :formex,
  validator: Formex.Validator.Vex,
  translate_error: &Formex.Validator.Vex.TestErrorHelpers.translate_error/1

config :logger, :console,
  level: :info