Dir[File.join(__dir__, "endpoints", "**", "*.rb")].each do |file|
  require file
end
