Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbUK3EIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbUK3EIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUK3EIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:08:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:42416 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261972AbUK3EIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:08:18 -0500
Date: Mon, 29 Nov 2004 20:07:53 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management
Message-ID: <20041130040753.GA8376@kroah.com>
References: <20041130024321.GA6317@kroah.com> <E1CYy3v-0005JM-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYy3v-0005JM-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 06:48:19PM -0800, Gerrit Huizenga wrote:
> 
> On Mon, 29 Nov 2004 18:43:21 PST, Greg KH wrote:
> > On Mon, Nov 29, 2004 at 10:44:49AM -0800, Gerrit Huizenga wrote:
> > > 09-diff_rbce
> > > 	A very basic rules based classification engine for automatically
> > > 	adding tasks to classes.  Also includes an enhanced rules based
> > > 	classification engine with better per-process delay data and
> > > 	ability to better monitor class related activities.
> > 
> > This one didn't look like it made it to lkml.
> > 
> > Oh, and I stopped reviewing the other patches in the series, as the same
> > comments pretty much applied to them :(
> 
> Yeah, I checked marc earlier and didn't see it there.  I'm making
> the suggested changes now, will resend the whole set when I apply
> and test a bit.

And the questions that I and others had about portions of the code?
Please address them in responses to the messages and don't expect us to
try to pick out if they are still present in the next round of patches
:)

thanks,

greg k-h
