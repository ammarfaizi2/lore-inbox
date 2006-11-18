Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756345AbWKRNAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbWKRNAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756346AbWKRNAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:00:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40156 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756344AbWKRNAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:00:22 -0500
Date: Sat, 18 Nov 2006 07:59:42 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Paul Mackerras <paulus@samba.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Message-ID: <20061118125942.GA17248@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com> <200611180929.12643.ak@suse.de> <17758.59055.613106.945095@cargo.ozlabs.ibm.com> <200611181158.15114.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611181158.15114.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 11:58:14AM +0100, Andi Kleen wrote:
> On Saturday 18 November 2006 11:55, Paul Mackerras wrote:
> > Andi Kleen writes:
> >
> > > On Friday 17 November 2006 23:59, Vivek Goyal wrote:
> > >
> > > > + *	Copyright (c) 2006-2007  Vivek Goyal (vgoyal@in.ibm.com)
> > >
> > > Normally it's not ok to take sole copyright on code that you mostly copied ...
> >
> > Is this a case where the original had no copyright notice?  If so,
> > what do you suggest Vivek should have done?
> 
> The head.S code this was copied from definitely had a copyright.
> 

I am sorry but I am completely unaware of the details of Copyright
information. Somebody please tell me what should be the right info
here given that basically I have taken the code from
arch/x86_64/boot/head.S, picked modifications done by Eric and minor
changes of my own.

Do I copy here all the copyright info of head.S and then add Eric's
name and mine too?

Thanks
Vivek

