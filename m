Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbTBDHFT>; Tue, 4 Feb 2003 02:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbTBDHFT>; Tue, 4 Feb 2003 02:05:19 -0500
Received: from [196.12.44.6] ([196.12.44.6]:21170 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S267132AbTBDHFS>;
	Tue, 4 Feb 2003 02:05:18 -0500
Date: Tue, 4 Feb 2003 12:43:32 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Amit Saxena <saxena@students.iiit.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Raphael Schmid <Raphael_Schmid@CUBUS.COM>
Subject: BootScreen : The LPP for 2.4.
Message-ID: <Pine.LNX.4.44.0302041232300.10692-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	Some days back there were some messages regarding the bootscreen.  
I have a port for the linux progress patch that works fine. I have tried 
it only on x86 but should work fine on others too.  I think we are not 
permitted to send attachments to this list. So i had to keep it on my 
homepage.  It can be downloaded from http://gdit.iiit.net/~prasad_s/lpp/

This is a simple port, which i did in order to tryout the progress patch. 
so there could be some problems. feel free to mail suggessions to me.

The patch is for 2.4.18-4 (The default kernel in redhat7.3). However 
theres an rpm of the same for redhat-8.0 (this rpm installs only the 
kernel support. so you will have to download and use files that are 
included in the patch tarball for redhat7.3)


Prasad.

-- 
Failure is not an option


