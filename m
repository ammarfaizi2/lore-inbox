Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSD3JzN>; Tue, 30 Apr 2002 05:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSD3JzM>; Tue, 30 Apr 2002 05:55:12 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.93]:55560 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S313181AbSD3JzL>; Tue, 30 Apr 2002 05:55:11 -0400
Subject: Re: [ANNOUNCE] LDM 0.0.6 (Windows Dynamic Disks)
From: Richard Russon <ntfs@flatcap.org>
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        sf <Linux-NTFS-Dev@lists.sourceforge.net>
In-Reply-To: <002e01c1ec76$1864a670$0201a8c0@homer>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4.99 
Date: 30 Apr 2002 10:54:44 +0100
Message-Id: <1020160485.9650.55.camel@addlestones>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Sorry for the slow reply, I made the announcement and went on holiday.

> It it in any way possible that by using the Linux-LDM patch be able to
> convert dynamic disks to basic disks?

The LDM patch just allows the kernel to understand Windows new
partitioning.  Without it you'll just see one BIG partition of type
0x42.

If you only have simple disks on a dynamic disk, then it shouldn't be
too hard to convert a dynamic disk back to a basic disk.  We don't
have a tool to do this yet.

Cheers,
    FlatCap (Rich)
    ntfs@flatcap.org

WWW: http://linux-ntfs.sf.net
IRC: #ntfs on irc.openprojects.net

