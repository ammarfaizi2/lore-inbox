Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267767AbTBVBEw>; Fri, 21 Feb 2003 20:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267769AbTBVBEw>; Fri, 21 Feb 2003 20:04:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:2815 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267767AbTBVBEv>;
	Fri, 21 Feb 2003 20:04:51 -0500
Date: Fri, 21 Feb 2003 17:12:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Older bk snapshots not found on www.kernel.org (fwd)
Message-Id: <20030221171220.0674e3f7.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302220158540.16168-100000@cam029208.student.utwente.nl>
References: <Pine.LNX.4.44.0302220158540.16168-100000@cam029208.student.utwente.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Feb 2003 01:14:52.0652 (UTC) FILETIME=[CD7A8AC0:01C2DA0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martijn Uffing <mp3project@cam029208.student.utwente.nl> wrote:
>
> 
> Ave people.
> 
> I know www.xx.kernel.org has nice bk snapshots in the form 
> of patch-2.5.x-bkx.gz  However,they are only against the latest linus 
> release. The problem is I have a 100% repeatable OOPS in 2.5.62 while 
> 2.5.61 worked.  Before I send in a bug report I want to nail it down to 
> which bk snapshot starts failing to make it a little easier for the 
> bughunters to find the bug.  Is there any website/ftp whatever which 
> collects older bk snapshots?

I just run a script to snarf them.

I've uploaded the 2.5.61->2.5.62 snapshots to

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.61/snapshots/

each one of these is a diff against 2.5.61.  If you can narrow it down to the
offending one, that would be a big start.

