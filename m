Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUE1FxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUE1FxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 01:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUE1FxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 01:53:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:52631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262337AbUE1FxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 01:53:10 -0400
Date: Thu, 27 May 2004 22:52:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1-mm1
Message-Id: <20040527225231.722c3a93.akpm@osdl.org>
In-Reply-To: <20040528054653.GB7499@pazke>
References: <20040527015259.3525cbbc.akpm@osdl.org>
	<20040527115327.GA7499@pazke>
	<20040527112041.531a52e4.akpm@osdl.org>
	<20040528054653.GB7499@pazke>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin <pazke@donpac.ru> wrote:
>
> On 148, 05 27, 2004 at 11:20:41AM -0700, Andrew Morton wrote:
> > Andrey Panin <pazke@donpac.ru> wrote:
> > >
> > > On 148, 05 27, 2004 at 01:52:59 -0700, Andrew Morton wrote:
> > > >
> > > > +make-proliant-8500-boot-with-26.patch
> > > > 
> > > >  Fix hpaq proliant 8500
> > > 
> > > Ugh, dmi_scan.c changed again ... :(
> > > 
> > 
> > Confused.  What's the problem with that?
> 
> Just yet another rediff of my DMI patches :)

err, what DMI patches?

> First patch attached

-ENOCHANGELOG.

> , other will follow.
> Can we apply them now ?

Well they won't get applied if they're stuck on your hard disk.  Send 'em over.
