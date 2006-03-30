Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWC3KcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWC3KcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWC3KcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:32:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47794 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932164AbWC3KcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:32:06 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	<1143228339.19152.91.camel@localhost.localdomain>
	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>
	<4428FB29.8020402@yahoo.com.au>
	<20060328142639.GE14576@MAIL.13thfloor.at>
	<44294BE4.2030409@yahoo.com.au>
	<m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>
	<442B4FD6.1050600@yahoo.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 30 Mar 2006 03:30:58 -0700
In-Reply-To: <442B4FD6.1050600@yahoo.com.au> (Nick Piggin's message of "Thu,
 30 Mar 2006 14:26:14 +1100")
Message-ID: <m1d5g4dy1p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> Yes... about that; if/when namespaces get into the kernel, you guys
> are going to start pushing all sorts of per-container resource
> control, right? Or will you be happy to leave most of that to VMs?

That will certainly be an aspect of it, and that is one of the
pieces of the ongoing discussion.  The out of tree implementations
already do this.

What flavor of resource limits these will be I don't know.  That
is a part of the discussion we are just coming to now.


Eric
