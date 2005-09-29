Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVI2Pqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVI2Pqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVI2Pqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:46:32 -0400
Received: from mail0.lsil.com ([147.145.40.20]:35773 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932203AbVI2Pqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:46:31 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C04388D88@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: ltuikov@yahoo.com, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into 
	the kernel
Date: Thu, 29 Sep 2005 09:45:59 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 29, 2005 6:46 AM, Luben Tuikov wrote:

> 
> On 09/28/05 18:17, Moore, Eric Dean wrote:
> > Can you stop this tirade, e.g. conspiracy theory,
> > in regards to LSI/MPT and the transport layer?
> 
> What conspiracy theory?
> 
> Oh you mean that one _technology_ is in the kernel
> and another distinct, radically _different_ is NOT?
> 
> Oh you mean that conspiracy theory?

Thats just plain crap.  And your trash talking is plan crap.
My sas drivers have been rejected for
more than a year now. They were only accepted in the  
past week.  During that time, I've had to endure many changes
in the driver to get them where they were accepted.  And that
has been very painful. I hope you know that we have support
CSMI/SDI interface (yes, we are SAS by the way). 
How do you suggest we do that? The IOCTLS were rejected.

> 
> > That is not the case.   There will be other sas 
> 
> I don't see our driver in the kernel, do you?
> 
> > solutions that implement discovery, and 
> > sas/sata translation in firmware, higher level
> > event handling.
> 
> Yes, and they would all be MPT-like technology.
> I don't have a problem with that.
> 
> What I have a problem with is that you folks
> just sit and watch this, while you could explain
> to James et al, that indeed the technologies
> are different and there is no reason NOT to include
> one but leave the other out.

Ok, fine, James Let them all in.  

I have never said to alientate any other technology.  
When did I ever say that?
I'm still not convinced that your sas transport will 
work with any other technology but yours.  Or will it?

Christophs sas transport layer is generic?  I see nothing there
that says "this is MPT".   I thought all along since OLS, that you 
were going to develop a layer that would work below it
for cards that don't have firmware assist? 
Are you working with these guys on that?   I thought that is 
what you were doing, or maybe I'm misunderstanding something here.
 
> 
> I was hoping you'd say something like, "Yeah, the
> technologies are different -- I don't see why one
> should be in and another not."
> 

I agree with you.  

