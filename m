Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbRCFGjP>; Tue, 6 Mar 2001 01:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRCFGjF>; Tue, 6 Mar 2001 01:39:05 -0500
Received: from [200.222.192.170] ([200.222.192.170]:58240 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129190AbRCFGis>; Tue, 6 Mar 2001 01:38:48 -0500
Date: Mon, 5 Mar 2001 03:37:35 -0300
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened ? (No such file or directory))
Message-ID: <20010305033735.D103@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
X-Mailer: Mutt/1.3.16i - Linux 2.4.2
X-URL: http://www.pervalidus.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I should give details about my hardware. The system was
installed 5 months ago, and this is the first problem.

I used 2.2.16 stock Kernel from Slackware 7.1
2.2.17
2.2.18
2.4.0
2.4.1

And the only problem was with 2.4.2.

FYI, I'm not using hdparm or changing the BIOS to use UDMA 66.
It'd fail with 2.4.1 and 2.4.2 (CRC errors), so the setting
is AUTO and it's using UDMA 33.

And please note that this machine is fine, but I actually only
open 2 consoles and run GNU screen. No XFree86, and only a few
applications running.

If needed, my /var/log/dmesg is at
http://members.nbci.com/pervalidus/dmesg-2.4.2.txt

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
