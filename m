Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272169AbRIENNm>; Wed, 5 Sep 2001 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272173AbRIENNc>; Wed, 5 Sep 2001 09:13:32 -0400
Received: from victor.ndsuk.com ([194.202.59.31]:20498 "EHLO victor.ndsuk.com")
	by vger.kernel.org with ESMTP id <S272169AbRIENNN>;
	Wed, 5 Sep 2001 09:13:13 -0400
Message-ID: <F128989C2E99D4119C110002A507409801556020@topper.hrow.ndsuk.com>
From: "Elgar, Jeremy" <JElgar@ndsuk.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Applying multiple patches
Date: Wed, 5 Sep 2001 14:14:12 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes I noticed that last night when I started looking through the .rej and
.orig file,
so beeing week I gave up and installed the ac7 patch only (least that got
the NetGear ea101 working) ill leave the file system ill ive got the laptop
set up,

still need to apply the xfsm path for an indy i have (but that will be on a
plain old
2.4.9

Cheers

Jeremy



> -----Original Message-----
> From: Thomas Duffy [mailto:Thomas.Duffy.99@alumni.brown.edu]
> Sent: 04 September 2001 23:54
> To: Elgar, Jeremy
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Applying multiple patches
> 
> 
> On Tue, 2001-09-04 at 06:07, Elgar, Jeremy wrote:
> 
> > The problem I have is thus,  I want to apply 
> patch-2.4.9-ac6 (I guess might
> > as well do ac7 now) and the xfs patch
> > but both are from a vanilla 2-4-9.
> 
> I would suggest not trying this out as your first patch conflict fix
> attempt.  Both xfs and ac are large and touch a bunch of core linux
> files.  Getting xfs to apply on top of ac requires an 
> intimate knowledge
> of the xfs (and some ac) code.  If you are interested in 
> trying out, see
> how it was done for the 2.4.3-SGI_XFS_1.0.1 rpm that SGI put out for
> xfs-enabled redhat 7.1.
> 
> If you download the src.rpm from oss.sgi.com/projects/xfs, 
> you will find
> an xfs patch that applies on an ac patch.  Now, both xfs and ac have
> changed a bunch from the 2.4.3 days, but this will give you a 
> good start
> at figuring out what was done to get the two to play nice together.
> 
> -tduffy
> 
> 


 
===============================================================
Information contained in this email message is intended only for
use of the individual or entity named above. If the reader of this
message is not the intended recipient, or the employee or agent
responsible to deliver it to the intended recipient, you are hereby
notified that any dissemination, distribution or copying of this
communication is strictly prohibited. If you have received this
communication in error, please immediately notify us by email
to postmaster@ndsuk.com and destroy the original message. 


