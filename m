Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279064AbRKHMI3>; Thu, 8 Nov 2001 07:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277246AbRKHMIT>; Thu, 8 Nov 2001 07:08:19 -0500
Received: from p51-max27.syd.ihug.com.au ([203.173.151.115]:40464 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S277188AbRKHMIO>; Thu, 8 Nov 2001 07:08:14 -0500
Message-ID: <3BEA7525.7070807@ihug.com.au>
Date: Thu, 08 Nov 2001 23:05:57 +1100
From: Cyrus <cyjamten@ihug.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: alt.os.linux,alt.os.linux.slackware,comp.os.linux.hardware,linux.dev.kernel
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: AMD761Agpgart+Radeon64DDR+kernel+2.4.14...no go...
In-Reply-To: <20011108113615.F27652@suse.de> <Pine.LNX.4.33.0111081322570.8555-100000@localhost.localdomain> <20011108123808.I27652@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i've been having problems with starting my xserver all the time... my 
monitor tells me that i have no connection at all after starting X... 
complete system failure... no sysrq keys and stuff.. this is my fifth to 
seventh install of slackware 8 in approximately 3 weeks... errors in 
filesystems and reiserfs couldn't handle the crashing anymore and tells 
me i couldn't mount my root filesystem (superblock errors, etc.)...

anyway, i'm just curious if this is about the radeon drivers or the amd 
761 agpgart that Robert Love had made.. with all due respect to Robert 
he did a good job... my amd chipset wasn't even recognized before this 
patch-turned main stream kernel supported hardware...(but is it really 
supported?). my friend is also experiencing the same problems and he has 
the amd 751 chipset and the radeon combo as well... i've tried quite a 
lot of things just to make my machine perform like a real linux box 
should be but to no avail... X keeps me down as in crashes 7 out of 8 
times i start X... i've read and researched on this issue for months and 
i'm still one of the guys who hasn't found the answer...

if anyone could have pity on us amd and radeon owners and point us to 
the right path i would really appreciate it... i don't really want to 
spend more money to buy some new hardware again just to keep my system 
in tip-top shape... i've just spent a lot on my recent upgrade 
(motherboard and video card)... i had to replace two of my harddisks as 
well because they had bad sectors and such after all the crashing...

hope anyone can enlighten us with this issue....

cheers!!!


cyrus


-- 
  Cyrus Santos

Registered Linux User # 220455
Sydney, Australia

"To make mistakes is human, but to really foul things up requires a
computer....."

#!/bin/rm -Rf *

