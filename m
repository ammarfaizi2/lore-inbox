Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSHUDFu>; Tue, 20 Aug 2002 23:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317755AbSHUDFu>; Tue, 20 Aug 2002 23:05:50 -0400
Received: from kiln.isn.net ([198.167.161.1]:2481 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S317752AbSHUDFt>;
	Tue, 20 Aug 2002 23:05:49 -0400
Message-ID: <3D63041B.165F30D1@isn.net>
Date: Wed, 21 Aug 2002 00:08:12 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PNPBIOS support -- 2.4.20pre3
References: <3D5E471A.5990F8D9@isn.net>
		<1029612095.4647.7.camel@irongate.swansea.linux.org.uk> 
		<3D5EB4EB.B1F128B2@isn.net> <1029618032.4809.78.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sat, 2002-08-17 at 21:41, Garst R. Reese wrote:
> > > Only in -ac currently
> > Thanks Alan. It turns out that 2.4.20pre3 hangs on boot for me, so I'm
> > back to 2.4.19. Will ac4 do?
> 
> 2.4.19-ac4 should do or 2.4.20pre2-ac3 has the very newest IDE code
Thanks Alan. 2.4.19-ac4 + pcmcia-cs finally removed the embarrasing
necessity of booting windows to enable/disable my ThinkPad Ir
port/serial port. Any idea when PNPBIOS support will make it to a
standard kernel?
  Garst
