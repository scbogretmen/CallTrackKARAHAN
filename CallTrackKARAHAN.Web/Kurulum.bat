@echo off
chcp 65001 >nul
title CallTrack KARAHAN - Kurulum
echo CallTrack KARAHAN kurulumu baslatiliyor...
echo Yonetici izni istenecek; "Evet" deyin.
echo.
powershell -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -NoProfile -File \"%~dp0Kurulum.ps1\"' -Verb RunAs -Wait"
if errorlevel 1 echo Bir hata olustu.
pause
