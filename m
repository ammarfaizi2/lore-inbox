Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289675AbSAWFP4>; Wed, 23 Jan 2002 00:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289673AbSAWFPq>; Wed, 23 Jan 2002 00:15:46 -0500
Received: from svr3.applink.net ([206.50.88.3]:2057 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289668AbSAWFPf>;
	Wed, 23 Jan 2002 00:15:35 -0500
Message-Id: <200201230512.g0N5CIr12742@home.ashavan.org.>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Wed, 23 Jan 2002 23:14:12 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Nofftz <nofftz@castor.uni-trier.de>, Dave Jones <davej@suse.de>,
        Andreas Jaeger <aj@suse.de>, Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201222310260.13313-100000@infcip10.uni-trier.de> <20020122224257Z289515-13997+8587@vger.kernel.org>
In-Reply-To: <20020122224257Z289515-13997+8587@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm confused by all of the posts and websites that
I've read.   In particular, some of the wattage and
temperature claims seem outrageous.   So, here's
what I've been able to discover		

1. According to AMD specs, the model 3 Duron's don't
use more that 40 Watts maximum. 

2. With my Duron 800 on a KT133A chipset
running folding@home and seti@home
continuously, LM sensors reports:

SYS Temp: +45.2°C  
CPU Temp: +35.1°C 
SBr Temp: +25.8°C


So, I see absolutely no cause for alarm, nor even a need for
lvcool (esp. not when running seti@home).   And  I certainly
haven't seen any Athlon PSE/AGP lockups.  So, are you all
overclockng your systems to an incredible amount (again, 
that's something that seems really stupid to me since the
$$ difference between 1GHz and 800MHz is not worth the
potential damage; and the duron is up to 1.3GHz now....)


-- 
timothy.covell@ashavan.org.
