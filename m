Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTDQRss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDQRsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:48:47 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:1964 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261825AbTDQRsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:48:46 -0400
Date: Thu, 17 Apr 2003 20:00:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-je2
Message-ID: <20030417180042.GA594@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Download from:
http://wh.fh-wedel.de/~joern/software/kernel/je/24/patch-2.4.20-je2

Included patches:
checkstack	- statically check functions for stack usage
stack_overflow	- print messages when 3k stack are used (7k without)
remove_charraw	- adds a config option for drivers/char/raw.o
msdospartitions	- don't always compile fs/partitions/msdos.o
net_802cleanup	- cleanup the Makefile and move 802.3 into ipx
CONFIG_BLKDISK	- put partitioning code etc. behind a config option
noswap		- add a config option for swap support
nohash		- experimental, unfinished, currently harmless

Access to the individual patches will follow.

Jörn

-- 
Invincibility is in oneself, vulnerability is in the opponent.
-- Sun Tzu
