Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTBXJml>; Mon, 24 Feb 2003 04:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbTBXJml>; Mon, 24 Feb 2003 04:42:41 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:17061 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265865AbTBXJmk>;
	Mon, 24 Feb 2003 04:42:40 -0500
Date: Mon, 24 Feb 2003 10:52:52 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: GAURAV YADAV <gaurav_christmas@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: newbie question :- installation problemo 0x44 error partition gone, please help me.
Message-ID: <20030224095252.GA14024@win.tue.nl>
References: <20030218124616.72541.qmail@web20508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218124616.72541.qmail@web20508.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 04:46:16AM -0800, GAURAV YADAV wrote:

> i have two hard disks
> 
> hda - > 4GB
> hdb - > 40GB
> hda has no partitions and windowsME is installed
> hdb has 12 partitions ( including Linux Native and
> Swap file system)
> 
> while i was installing linux7.1
> when i was in Diskurid for partitioning
> it told filesystem as 0x44 instead of Win95 FAT,
> but i ignored it and went ahead installing Linux.
> It went really very fine with no problems.
> but when i restarted it is showing me partitions
> of hdb in cfidsk but when i want to mount it is not
> mounting
> and say 'are you trying to mount extended partition?'
> and in cfdisk also it is showing partitions as
> Unknown,
> Even windows is not recognising those partitions of
> hdb. Is all my data lost forever, i am having very
> important data on my disk regarding my studies.

You are not using GoBack are you?

What are the kernel boot messages for these disks?
(dmesg | grep hd)

mailto aeb@cwi.nl
