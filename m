Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUK3GM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUK3GM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUK3GM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:12:27 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:9931 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262009AbUK3GMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:12:23 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management 
In-reply-to: Your message of Mon, 29 Nov 2004 20:07:53 PST.
             <20041130040753.GA8376@kroah.com> 
Date: Mon, 29 Nov 2004 21:59:51 -0800
Message-Id: <E1CZ13I-0007zD-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 20:07:53 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 06:48:19PM -0800, Gerrit Huizenga wrote:
> > 
> > On Mon, 29 Nov 2004 18:43:21 PST, Greg KH wrote:
> > > On Mon, Nov 29, 2004 at 10:44:49AM -0800, Gerrit Huizenga wrote:
> > > > 09-diff_rbce
> > > > 	A very basic rules based classification engine for automatically
> > > > 	adding tasks to classes.  Also includes an enhanced rules based
> > > > 	classification engine with better per-process delay data and
> > > > 	ability to better monitor class related activities.
> > > 
> > > This one didn't look like it made it to lkml.
> > > 
> > > Oh, and I stopped reviewing the other patches in the series, as the same
> > > comments pretty much applied to them :(
> > 
> > Yeah, I checked marc earlier and didn't see it there.  I'm making
> > the suggested changes now, will resend the whole set when I apply
> > and test a bit.
> 
> And the questions that I and others had about portions of the code?
> Please address them in responses to the messages and don't expect us to
> try to pick out if they are still present in the next round of patches
> :)

Yeah, yeah, working on it.  Will generically apply a number of your
changes.  Just sent you a couple of questions about a couple of other
changes.

gerrit
