Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263349AbSJFHDy>; Sun, 6 Oct 2002 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263350AbSJFHDy>; Sun, 6 Oct 2002 03:03:54 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:30143 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S263349AbSJFHDx>; Sun, 6 Oct 2002 03:03:53 -0400
Date: Sun, 6 Oct 2002 03:09:38 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40-ac4 Starting X kills mouse & keyboard
Message-ID: <20021006070938.GB2376@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS P4S533 (SiS645DX chipset)
P4 2Ghz
1G PC2700 RAM
nvidia GeForce2 GTS (using XFree86 "nv" driver)
ps/2 style keyboard & mouse

Mandrake 9.0
XFree86 Version 4.2.1 / X Window System
(protocol Version 11, revision 0, vendor release 6600)

Boot to console. Login. Run console apps with no problem.
startx
Keyboard numlock led goes off
mouse pointer appears - doesn't respond to mouse movement
keyboard unresponsive
X loads apps specified in .xinitrc

Can't do anything without a mouse or keyboard except power off.
Works fine for other kernels.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

