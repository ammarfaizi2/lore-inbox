Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755276AbWKRRqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbWKRRqc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 12:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755278AbWKRRqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 12:46:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52361 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1755276AbWKRRqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 12:46:31 -0500
Date: Sat, 18 Nov 2006 18:46:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, rjw@sisk.pl
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Message-ID: <20061118174609.GA9839@elf.ucw.cz>
References: <20061117223432.GA15449@in.ibm.com> <200611180929.12643.ak@suse.de> <17758.59055.613106.945095@cargo.ozlabs.ibm.com> <200611181158.15114.ak@suse.de> <20061118125942.GA17248@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118125942.GA17248@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > + *	Copyright (c) 2006-2007  Vivek Goyal (vgoyal@in.ibm.com)
> > > >
> > > > Normally it's not ok to take sole copyright on code that you mostly copied ...
> > >
> > > Is this a case where the original had no copyright notice?  If so,
> > > what do you suggest Vivek should have done?
> > 
> > The head.S code this was copied from definitely had a copyright.
> > 
> 
> I am sorry but I am completely unaware of the details of Copyright
> information. Somebody please tell me what should be the right info
> here given that basically I have taken the code from
> arch/x86_64/boot/head.S, picked modifications done by Eric and minor
> changes of my own.
> 
> Do I copy here all the copyright info of head.S and then add Eric's
> name and mine too?

Yes, that's "the safest" method to do it. (Or most politicaly correct
or something.)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
