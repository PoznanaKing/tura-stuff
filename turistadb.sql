-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Már 03. 12:08
-- Kiszolgáló verziója: 10.4.20-MariaDB
-- PHP verzió: 7.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `turistadb`
--
CREATE DATABASE IF NOT EXISTS `turistadb` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `turistadb`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `nehezseg`
--

CREATE TABLE `nehezseg` (
  `Id` int(11) NOT NULL,
  `jelzes` varchar(1) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `leiras` varchar(128) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `nehezseg`
--

INSERT INTO `nehezseg` (`Id`, `jelzes`, `leiras`) VALUES
(1, 'A', 'fizikailag könnyű, bárki számára teljesíthető egész napos séta.'),
(2, 'B', 'fizikailag közepesen megerőltető túra. Rendszeresen mozgó vándoroknak ajánljuk.'),
(3, 'C', 'fizikailag nehéz túra. Rendszeresen sportoló (hetente néhány alkalommal) túrázóknak ajánljuk.'),
(4, 'D', 'fizikailag nagyon nehéz túra. Kitűnő kondícióval rendelkező túrázóknak ajánljuk.'),
(5, 'E', 'extrém fizikai igénybevételt jelentő VÁNDORLÁSS. Speciális felkészülést igényel. Előzetes konzultáció a túravezetővel feltétel.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tura`
--

CREATE TABLE `tura` (
  `Id` int(11) NOT NULL,
  `idopont` datetime DEFAULT NULL,
  `utvonalID` int(11) DEFAULT NULL,
  `turavezetoID` int(11) DEFAULT NULL,
  `koltseg` int(11) DEFAULT NULL,
  `maxletszam` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `tura`
--

INSERT INTO `tura` (`Id`, `idopont`, `utvonalID`, `turavezetoID`, `koltseg`, `maxletszam`) VALUES
(1, '2025-02-24 12:33:58', 2, 1, 0, 10),
(2, '2025-02-24 12:33:58', 2, 1, 0, 10);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `turavezeto`
--

CREATE TABLE `turavezeto` (
  `Id` int(11) NOT NULL,
  `Nev` varchar(64) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `Telefon` varchar(15) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `email` varchar(32) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `minosites` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `turavezeto`
--

INSERT INTO `turavezeto` (`Id`, `Nev`, `Telefon`, `email`, `minosites`) VALUES
(1, 'Kiss Ferenc', '+3630-123-4567', 'kissferenc@mail.hu', 1),
(2, 'Nagy Károly', '+3630-111-4567', 'nagyk@mail.hu', 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `utvonal`
--

CREATE TABLE `utvonal` (
  `Id` int(11) NOT NULL,
  `allomasok` varchar(256) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `tav` int(11) DEFAULT NULL,
  `szint` int(11) DEFAULT NULL,
  `nehezsegID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `utvonal`
--

INSERT INTO `utvonal` (`Id`, `allomasok`, `tav`, `szint`, `nehezsegID`) VALUES
(1, 'Ómassa-Szentlélek-Dédes vár-Bánkút-Ómassa', 20, 450, 4),
(2, 'Majális park-Szeleta barlang-Lillafüred', 8, 200, 2);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `nehezseg`
--
ALTER TABLE `nehezseg`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `tura`
--
ALTER TABLE `tura`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `utvonalID` (`utvonalID`,`turavezetoID`),
  ADD KEY `turavezetoID` (`turavezetoID`);

--
-- A tábla indexei `turavezeto`
--
ALTER TABLE `turavezeto`
  ADD PRIMARY KEY (`Id`);

--
-- A tábla indexei `utvonal`
--
ALTER TABLE `utvonal`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `nehezsegID` (`nehezsegID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `nehezseg`
--
ALTER TABLE `nehezseg`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `tura`
--
ALTER TABLE `tura`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `turavezeto`
--
ALTER TABLE `turavezeto`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `utvonal`
--
ALTER TABLE `utvonal`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `tura`
--
ALTER TABLE `tura`
  ADD CONSTRAINT `tura_ibfk_1` FOREIGN KEY (`utvonalID`) REFERENCES `utvonal` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tura_ibfk_2` FOREIGN KEY (`turavezetoID`) REFERENCES `turavezeto` (`Id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `utvonal`
--
ALTER TABLE `utvonal`
  ADD CONSTRAINT `utvonal_ibfk_1` FOREIGN KEY (`nehezsegID`) REFERENCES `nehezseg` (`Id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
