Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266409AbSLNDOE>; Fri, 13 Dec 2002 22:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbSLNDOE>; Fri, 13 Dec 2002 22:14:04 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:47335 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S266409AbSLNDOD>; Fri, 13 Dec 2002 22:14:03 -0500
Date: Fri, 13 Dec 2002 22:21:44 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-ac2 panics at end of running initscripts
Message-ID: <20021214032144.GA2033@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS P4S533 (SiS645DX chipset)
P4 2G
1G PC2700 RAM

2.4.20-ac2 panics at the end of running initscripts
/var/log/messages and /var/log/syslog are corrupted
(looks like a file list, but random unprintable 
characters garbage in between each filename).
Due to the corruption of the logs I'm not too keen
on playing with it much to figure out what it's doing.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

