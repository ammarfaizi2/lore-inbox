Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSATTd7>; Sun, 20 Jan 2002 14:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSATTdt>; Sun, 20 Jan 2002 14:33:49 -0500
Received: from mustard.heime.net ([194.234.65.222]:39145 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288955AbSATTdi>; Sun, 20 Jan 2002 14:33:38 -0500
Date: Sun, 20 Jan 2002 20:33:25 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Christian Hammers <ch@westend.com>, <ext2-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] ext3 fs corruption with 2.4.17
In-Reply-To: <20020118104846.Q29178@lynx.adilger.int>
Message-ID: <Pine.LNX.4.30.0201202031270.13442-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I keep getting the exact same error

EXT3-fs error (device ide2(33,0)): ext3_new_block: Allocating block in system zone - block = 884763
EXT3-fs error (device ide2(33,0)): ext3_new_block: Allocating block in system zone - block = 884764
EXT3-fs error (device ide2(33,0)): ext3_new_block: Allocating block in system zone - block = 884765
EXT3-fs error (device ide2(33,0)): ext3_new_block: Allocating block in system zone - block = 884766
EXT3-fs error (device ide2(33,0)): ext3_new_block: Allocating block in system zone - block = 884767
...

The fs is newly created, and the computer has been working fine all the time.

Anyone know what this is ?

I'm running 2.4.17-tux-ide-rmap11c


roy
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

