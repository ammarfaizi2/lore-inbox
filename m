Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbRE2U6r>; Tue, 29 May 2001 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261827AbRE2U61>; Tue, 29 May 2001 16:58:27 -0400
Received: from brauhaus.paderlinx.de ([194.122.103.4]:18580 "EHLO
	imail.paderlinx.de") by vger.kernel.org with ESMTP
	id <S261805AbRE2U60>; Tue, 29 May 2001 16:58:26 -0400
Date: Tue, 29 May 2001 22:58:00 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Promise Ultra 100 TX2
Message-ID: <20010529225800.A7709@citd.de>
In-Reply-To: <Pine.LNX.4.20.0105291826220.32482-100000@citd.owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.20.0105291826220.32482-100000@citd.owl.de>; from ms@citd.de on Tue, May 29, 2001 at 06:30:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just bought one of $subject (PDC 20268)
> 
> Removed a Ultra 66 from my system and plugged the new one into the 66Mhz
> PCI-Bus (Intependent from the 33Mhz PCI-Bus (Tyan Thunder HE-SL Mainboard
> with Serverworks HE-SL-Chipset))
> 
> Kernel is 2.4.4 with Promise support compiled in. (The Ultra 66 works like
> a charm with this kernel)
> 
> 
> But the new controller wasn't deteced by the IDE-Subsystem AT ALL. (It
> only showed the onboard OSB4-Adapter)

with "ide.2.4.4-p1.04092001.patch.bz2" it now works like a charm. :-)

(As there is no update in 2.4.5 or in (current) 2.4.5ac4 i look what Andre
has produced and found that patch.)





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

