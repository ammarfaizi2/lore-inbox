Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUCJWrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUCJWrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:47:42 -0500
Received: from emulex.emulex.com ([138.239.112.1]:57751 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S262867AbUCJWrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:47:22 -0500
Message-ID: <3356669BBE90C448AD4645C843E2BF2802C014F1@xbl.ma.emulex.com>
From: "Smart, James" <James.Smart@Emulex.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [Announce] Emulex LightPulse Device Driver
Date: Wed, 10 Mar 2004 17:47:11 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, thanks to those that have actually taken a look at the FAQ and source
already. Do not believe your time was in vain - we will use every comment we
receive.

We know there are a lot of issues we need to address. We echo many of the
same sentiments. We had hoped the FAQ would explain where we are and where
we are heading, so that people can judiciously choose when to evaluate the
code base. That said, we will welcome any comments, at any time, at any
detail level. I would hope that, even while the code base is changing, that
we receive comments. There are constructs in the driver that are likely not
going to change, such as the logging facility. How contentious is this ?
What about the IP interfaces? and so on.  Anything we receive, especially on
the larger concepts in the driver, only helps us understand what's ahead. 

Our plans are to complete most of the work list on the FAQ by early April.
We'll try to make weekly drops on SourceForge, with each snapshot containing
a log of the changes.  Once the code base matures, we will ping the lists
again, asking for feedback.

Thanks.

-- James Smart


> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
> Sent: Wednesday, March 10, 2004 10:21 AM
> To: Jeff Garzik
> Cc: Smart, James; 'linux-scsi@vger.kernel.org';
> 'linux-kernel@vger.kernel.org'
> Subject: Re: [Announce] Emulex LightPulse Device Driver
> 
> 
> On Wed, 2004-03-10 at 03:35, Jeff Garzik wrote:
> > Embark you shall, and let me join in the chorus of kudos 
> for making the 
> > leap to open source.  :)
> 
> Yes, I'll add my welcome to that.
> 
> [...]
> > That should get you started ;-)
> 
> Actually, it would be my interpretation of the FAQ that most of this
> work is already intended (although Jeff gave specific 
> instances than the
> generalities in the FAQ).
> 
> There were many more places than this in the driver that 
> caused me to go
> "good grief no".  However, it probably makes more sense if 
> you work down
> your todo list and come back for a review when you're nearing 
> the end of
> it.  That way you don't get boat loads of comments about 
> things you were
> planning to fix anyway.
> 
> James
> 
> 
