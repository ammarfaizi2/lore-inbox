Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289521AbSAVW6C>; Tue, 22 Jan 2002 17:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289532AbSAVW5w>; Tue, 22 Jan 2002 17:57:52 -0500
Received: from bs1.dnx.de ([213.252.143.130]:62370 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S289521AbSAVW5h>;
	Tue, 22 Jan 2002 17:57:37 -0500
Date: Tue, 22 Jan 2002 23:55:30 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: <linux-embedded@waste.org>
Subject: New version of AMD Elan patch available
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201222347301.893-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[please send comments per mail]

today it's quick-release-time. There's another version of the AMD Elan
patch available which adds Sven Geggus' driver for changing the CPU
frequency. See the latest patch on

  http://www.pengutronix.de/software/elan_en.html

Please note that this is a very first and experimental version of this
driver. The API will most likely change to the cpufreq API from the ARM
architecture (Dave, I'll have a look at it tomorrow).

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+


