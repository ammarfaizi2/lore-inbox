Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313073AbSC0SrH>; Wed, 27 Mar 2002 13:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313072AbSC0Sqr>; Wed, 27 Mar 2002 13:46:47 -0500
Received: from bs1.dnx.de ([213.252.143.130]:60600 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S313071AbSC0Sqq>;
	Wed, 27 Mar 2002 13:46:46 -0500
Date: Wed, 27 Mar 2002 19:46:24 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Networking with slow CPUs
Message-ID: <Pine.LNX.4.33.0203271944020.16178-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in the 2.2 series there was a switch for "CPU is too slow to handle full
bandwidth" which has gone in 2.4. Can anybody tell me the reason for this?

Is there a possibility to "harden" a small machine (33 MHz embedded
device) against e.g. flood pings from the outside world?

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

