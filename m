Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290014AbSAKQtD>; Fri, 11 Jan 2002 11:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290013AbSAKQso>; Fri, 11 Jan 2002 11:48:44 -0500
Received: from [194.234.65.222] ([194.234.65.222]:65220 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S290011AbSAKQs1>; Fri, 11 Jan 2002 11:48:27 -0500
Date: Fri, 11 Jan 2002 17:48:25 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Loop-back block device?
Message-ID: <Pine.LNX.4.30.0201111744490.5203-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I apologize if this is question doesn't belong here, but I haven't found
any answers anywhere I've been looking.

What I want to do...

dd if=/dev/hda of=/some/file/on/another/larger/drive
mk_block_dev /some/file/on/another/larger/drive
cat /proc/partitions
[here the partitions on the (latter) /dev/hda will show up

and - after this - mount the partitions.

Thanks all

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

