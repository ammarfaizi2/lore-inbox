Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbUK3CzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbUK3CzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUK3CzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:55:11 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:22917 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261591AbUK3CzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:55:02 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management 
In-reply-to: Your message of Mon, 29 Nov 2004 18:43:21 PST.
             <20041130024321.GA6317@kroah.com> 
Date: Mon, 29 Nov 2004 18:48:19 -0800
Message-Id: <E1CYy3v-0005JM-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Nov 2004 18:43:21 PST, Greg KH wrote:
> On Mon, Nov 29, 2004 at 10:44:49AM -0800, Gerrit Huizenga wrote:
> > 09-diff_rbce
> > 	A very basic rules based classification engine for automatically
> > 	adding tasks to classes.  Also includes an enhanced rules based
> > 	classification engine with better per-process delay data and
> > 	ability to better monitor class related activities.
> 
> This one didn't look like it made it to lkml.
> 
> Oh, and I stopped reviewing the other patches in the series, as the same
> comments pretty much applied to them :(

Yeah, I checked marc earlier and didn't see it there.  I'm making
the suggested changes now, will resend the whole set when I apply
and test a bit.

gerrit
