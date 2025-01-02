import mill._, scalalib._

object core extends Cross[CoreModule](
  "2.12.20",  // Latest 2.12
  "2.13.15",  // Latest 2.13
  "3.3.4",    // LTS version
  "3.6.2"     // Latest version
)

trait CoreModule extends Cross.Module[String] with ScalaModule {
  def scalaVersion = crossValue
}
