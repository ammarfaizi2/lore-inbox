Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSKYGsh>; Mon, 25 Nov 2002 01:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSKYGsh>; Mon, 25 Nov 2002 01:48:37 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:56984 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262486AbSKYGsg>; Mon, 25 Nov 2002 01:48:36 -0500
Date: Mon, 25 Nov 2002 01:55:26 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.49 Keyboard and mouse lost in X
Message-ID: <20021125065525.GA1628@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got past the not-boot (need to set root=/dev/ide/host0 .... instead 
of /dev/hda10). Wasn't a reiserfs issue after all.

But - ran into the same keyboard and mouse not responding in X that has
plagued me in all the 2.5.4x kernels (and recent 2.4.20-xxx)

APIC on/off doesn't help.
ACPI on/off doesn't help.

ASUS P4S533 (SiS645DX chipset)
P4 2GHz
1G PC2700 RAM

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

