Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262522AbSJGDN0>; Sun, 6 Oct 2002 23:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbSJGDN0>; Sun, 6 Oct 2002 23:13:26 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:1415 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262522AbSJGDNZ>; Sun, 6 Oct 2002 23:13:25 -0400
Date: Sun, 6 Oct 2002 23:19:16 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 loses keyboard and mouse in X
Message-ID: <20021007031916.GA1732@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what info is needed here - there are no error messages anywhere.

ASUS P4S533 (SiS645DX chipset)
P4 2Ghz cpu
1G PC2700 RAM
SBLive! value (using ALSA driver)
NVidia GeForce2 GTS (using XFree86 nv driver)
PS/2 Keyboard & mouse

Mandrake 9.0
XFree86 4.2.1

Boot to console & login with no problem.
Run console apps with no problem.
run startx and X appears to start normally, but keyboard and mouse
are dead.
Only thing in .xinitrc is
  exec /usr/X11R6/bin/startfluxbox

No new messages in any log files.

Same thing happens with 2.5.40-ac2 & -ac4.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

