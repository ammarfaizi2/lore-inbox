Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSLFNW7>; Fri, 6 Dec 2002 08:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSLFNW7>; Fri, 6 Dec 2002 08:22:59 -0500
Received: from mail.bfad.de ([212.62.208.67]:39942 "EHLO
	mailserver.intern.bfad.de") by vger.kernel.org with ESMTP
	id <S262528AbSLFNW7>; Fri, 6 Dec 2002 08:22:59 -0500
Date: Fri, 6 Dec 2002 14:31:10 +0100 (CET)
From: tomasz motylewski <T.Motylewski@bfad.de>
To: Hiroshi Miura <miura@da-cha.org>,
       Christer Weinigel <wingel@hog.ctrl-c.liu.se>
cc: Zwane Mwaikambo <zwane@commfireservices.com>, linux-kernel@vger.kernel.org
Subject: [REPORT] Geode crashed 2.4.17, runs under 2.4.19
Message-ID: <Pine.LNX.4.21.0212061256350.11111-100000@mailserver.intern.bfad.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have bothered you few months ago that the following Geode modules:

Centarus platform, GX1 300 MHz, 5530A REv B1, BIOS: XpressROM V3.0.1 build 03/08/2001 by NatSemi

were crashing about once a week running 2.4.17 with low latency, HZ=2000,
ext3fs.

Since then I have upgraded to 2.4.19-rc3 with similar configuration and the
boards are running OK since a few months.

Best regards,
--
Tomasz Motylewski
BFAD GmbH & Co. KG

