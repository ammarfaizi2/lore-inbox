Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUHORkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUHORkp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUHORkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:40:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56783 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266004AbUHORkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:40:36 -0400
Date: Sun, 15 Aug 2004 19:40:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER -> depends HOTPLUG]
Message-ID: <20040815174028.GM1387@fs.tum.de>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org> <Pine.LNX.4.58.0408120027330.20634@scrub.home> <20040814074953.GA20123@mars.ravnborg.org> <20040814210523.GG1387@fs.tum.de> <Pine.LNX.4.61.0408151932370.12687@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408151932370.12687@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 07:35:53PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 14 Aug 2004, Adrian Bunk wrote:
> 
> > Unless I misunderstood Roman, FW_LOADER should be no longer selected.
> 
> Use it if you really need to, but just don't use it as convenient 
> replacement for depends.

And what's the correct handling of dependencies the selected symbol has?

FW_LOADER depends on HOTPLUG, and this was the issue that started the 
whole thread.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

