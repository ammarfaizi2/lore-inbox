Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269154AbTB0DEP>; Wed, 26 Feb 2003 22:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269155AbTB0DEO>; Wed, 26 Feb 2003 22:04:14 -0500
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:60085 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S269154AbTB0DEO>; Wed, 26 Feb 2003 22:04:14 -0500
Date: Thu, 27 Feb 2003 04:12:41 +0100 (CET)
From: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
To: akpm@digeo.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Older bk snapshots not found on www.kernel.org 
Message-ID: <Pine.LNX.4.44.0302270405530.21643-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2003, Andrew Morton wrote:

> Martijn Uffing <mp3project@cam029208.student.utwente.nl> wrote:
> >
> > 
> > Ave people.
> > 
> > I know www.xx.kernel.org has nice bk snapshots in the form 
> > of patch-2.5.x-bkx.gz  However,they are only against the latest linus 
> > release. The problem is I have a 100% repeatable OOPS in 2.5.62 while 
> > 2.5.61 worked.  Before I send in a bug report I want to nail it down to 
> > which bk snapshot starts failing to make it a little easier for the 
> > bughunters to find the bug.  Is there any website/ftp whatever which 
> > collects older bk snapshots?
> 
> I just run a script to snarf them.
> 
> I've uploaded the 2.5.61->2.5.62 snapshots to
> 
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.61/snapshots/
> 
> each one of these is a diff against 2.5.61.  If you can narrow it down to the
> offending one, that would be a big start.
> 

Ave 

I downloaded the different csets and compiled them. However,before 
that was finished and I could test them Trond posted some patch on the 
mailing list that fixed my OOPS.(my OOPS was nfsroot related)  
Anyway thanx for the csets and the quick respons ,next time I got a Oops I 
know where to look for the csets. The next bug is mine to hunt :)

Greetz Mu



