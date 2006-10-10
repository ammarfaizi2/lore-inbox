Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWJJTZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWJJTZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWJJTZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:25:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932271AbWJJTZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:25:24 -0400
Date: Tue, 10 Oct 2006 12:25:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061010122511.8232e9d5.akpm@osdl.org>
In-Reply-To: <452BE1DC.9030503@goop.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<452BE1DC.9030503@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 11:09:32 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > +generic-implementatation-of-bug.patch
> > +generic-implementatation-of-bug-fix.patch
> > +generic-bug-for-i386.patch
> > +generic-bug-for-x86-64.patch
> > +uml-add-generic-bug-support.patch
> > +use-generic-bug-for-ppc.patch
> > +bug-test-1.patch
> >   
> 
> No generic-bug for powerpc?  Still broken?
> 

I didn't do anything to fix it.  But I haven't tested it recently - it
might have repaired itself ;)

My plan was to pathetically spam the powerpc guys with it once all the
above is merged up.  I took a close look and couldn't see why it was
failing.

