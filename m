Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132887AbRDENHA>; Thu, 5 Apr 2001 09:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132888AbRDENGu>; Thu, 5 Apr 2001 09:06:50 -0400
Received: from mailimailo.univ-rennes1.fr ([129.20.131.1]:19870 "EHLO
	mailimailo.univ-rennes1.fr") by vger.kernel.org with ESMTP
	id <S132887AbRDENGk>; Thu, 5 Apr 2001 09:06:40 -0400
Date: Thu, 5 Apr 2001 16:36:16 +0200 (CEST)
From: Thomas Speck <Thomas.Speck@univ-rennes1.fr>
To: mmcclell@bigfoot.com
cc: LKML <linux-kernel@vger.kernel.org>
Subject: ov511 problem
In-Reply-To: <20010405133051.A16246@miggy.org>
Message-ID: <Pine.LNX.4.21.0104051625170.8028-100000@pc-astro.spm.univ-rennes1.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I am trying to get working a Spacec@m 300 (USB) by Trust. I tried this
under 2.2.18 and 2.4.3. In order to get the camera detected I can use the
usb-uhci or uhci module (the result is the same). The camera gets detected
(some OV7610 gets probed - I don't know if this is the correct one) and
after loading the ov511 module I get the picture of the camera displayed
with xawt-3.38 (resolution 640x480 - the camera is able to this). 
The problem I am running into is that the framerate is extremely slow
(maybe 3 fps), however, from the specifications it should work with 30
fps. My system is a Pentium II with 300 Mhz. Some Miro TV card with a
BT848 chip works fine with the bttv driver. 
Do you have any idea ? 
If you need more info, just let me know. I am also willing to do some
tests...

--
Thomas

