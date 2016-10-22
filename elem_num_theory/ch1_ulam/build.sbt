lazy val commonSettings = Seq(
  organization := "com.waywardcode",
  version := "1.0",
  scalaVersion := "2.12.0-RC2",  
  scalacOptions := Seq("-opt:l:classpath")
)


lazy val progs = (project in file(".")).
  settings(commonSettings: _*).
  settings(
    name := "nth_ulam"
  )
  
