Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269056AbTBWX6H>; Sun, 23 Feb 2003 18:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269057AbTBWX6G>; Sun, 23 Feb 2003 18:58:06 -0500
Received: from jpd.net1.nerim.net ([80.65.226.49]:38922 "EHLO
	removethis.junk.org") by vger.kernel.org with ESMTP
	id <S269056AbTBWX6F>; Sun, 23 Feb 2003 18:58:05 -0500
Date: Mon, 24 Feb 2003 00:08:11 +0000
From: Julien Plissonneau Duquene 
	<lkml.20030224@julien.plissonneau.duquene.net>
To: linux-kernel@vger.kernel.org
Subject: ide ioctls draft manpage - feedback wanted
Message-ID: <20030224000811.GA14003@junk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I needed a doc to HDIO_... ioctls, couldn't find any, and decided to
write my own. I use those to write data (or drives) recovery programs
that bypass almost completely the block I/O. The programs are not
written yet, I would like to understand the IDE layer first.

It can be found here :
http://junk.org/~jpd/kernelstuff/ide_ioctls
for the "formatted" edition, just add .4 for the source code.

This is about kernel 2.4.19, I lack bandwidth/time/drive
space/financial incentives to upgrade. Mostly bandwidth. And thus I will
follow the discussions on the list archives, so don't expect replies in
the minute.

If you know better than me on the subject (e.g. you write IDE drivers,
IDE utilities that need to send raw commands, or are among the IDE
maintainers) I would like to hear from you. There are blanks on the
page, stuff I guessed, and stuff I don't really understand.

Thanks in advance for help.

-- 
Julien Plissonneau Duquène.

