Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTLJCSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbTLJCSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:18:39 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:22216 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S263388AbTLJCSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:18:37 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: need hardware guru
Date: Tue, 9 Dec 2003 21:18:36 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092118.36657.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.57.120] at Tue, 9 Dec 2003 20:18:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mobo is a Biostar M7VIB, VIA 82686 chipset.

It appears that thre doesn't seem to be a way to force a floppy format 
at non 512 byte sectors, as in I need to do a 256 byte, 18 sectors 
per track on a  DS 360k disk.  fdutils, fdformat, and a format from 
the emulator itself all fail to write a correct disk, insisting on a 
9 sector per track PC format.

Ideas, including bigger hammer at this point, cheerfully discussed.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

