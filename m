Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129554AbRCBWHu>; Fri, 2 Mar 2001 17:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129590AbRCBWH0>; Fri, 2 Mar 2001 17:07:26 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:7684 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129578AbRCBWGM>;
	Fri, 2 Mar 2001 17:06:12 -0500
Date: Thu, 1 Mar 2001 12:46:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Ph. Marek" <marek@mail.bmlv.gv.at>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel bug in inode.c:885 when floppy disk removed
Message-ID: <20010301124634.F34@(none)>
In-Reply-To: <3.0.6.32.20010228160302.0092f100@pop3.bmlv.gv.at> <Pine.GSO.4.21.0102281020390.7107-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0102281020390.7107-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Feb 28, 2001 at 10:21:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > 1:
> > Kernel bug/Segmentation fault when floppy disk removed 2nd time
> > 
> > 
> > 2: 
> > Segmentation fault in a program, 
> > hanging processes in "D"-state,
> > Kernel bug in inode.c:885!
> > 
> > when removing floppy disk before unmounting and then using again
> 
> - Doctor, it hurts when I do it!
> - Don't do it, then.

That's not right answer. Think floppy error.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

