Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312141AbSCQX7F>; Sun, 17 Mar 2002 18:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312143AbSCQX64>; Sun, 17 Mar 2002 18:58:56 -0500
Received: from 26-072.104.popsite.net ([64.24.54.72]:7940 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S312141AbSCQX6f>; Sun, 17 Mar 2002 18:58:35 -0500
Message-Id: <200203172358.g2HNwPo01891@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dave Jones <davej@suse.de>, Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, dougg@torque.net
Subject: Re: Linux 2.5.6-dj1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Mar 2002 18:58:25 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert <dougg@torque.net> said:
> There are over 30 scsi subsystem patches backed up in
> your tree. Some are over 2 months old. Could
> some (or perhaps all) of them get promoted to the
> main tree? 

davej@suse.de said:
>  Indeed. Once Linus returns from vacation, I'll be doing a
>  patch-bombing on a larger scale than usual 8-)
>  Any bits I'm uncertain of, I'll bounce your way first for
>  clarification, deal ?

This really brings up a very important point.  As Doug has said before, since 
there are quite a few patches floating around on the SCSI list and other 
discussion of structural alteration in there, could we not have our own 
bitkeeper repository for the SCSI subsystem to keep them all in (and so that 
we can roll our own patch sets from)?

Jens, you're now listed as the SCSI maintainer so you are the person who is 
supposed to serve as a conduit to Linus for all of the SCSI patches.  You 
would also be the logical person to look after a SCSI bitkeeper repository, so 
will you look after one for us?  I can volunteer to help, and I'm sure others 
will.

I'm getting pretty tired of the snide comments from HW manufacturers and other 
OS interests about the state of our SCSI subsystem (not to mention 
unfavourable comparisons from the IDE guys).  Perhaps something like this 
could galvanise the community and serve as a catalyst for a general 
streamlining of the subsystem.

James


