Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVCaBVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVCaBVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVCaBVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:21:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:20948 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262502AbVCaBV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:21:27 -0500
Subject: Re: 2.6.11, USB: High latency?
From: Lee Revell <rlrevell@joe-job.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503301713.19920.david-b@pacbell.net>
References: <200503301457.35464.david-b@pacbell.net>
	 <1112229816.19975.9.camel@mindpipe>
	 <200503301713.19920.david-b@pacbell.net>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 20:21:26 -0500
Message-Id: <1112232086.19975.30.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 17:13 -0800, David Brownell wrote:
> On Wednesday 30 March 2005 4:43 pm, Lee Revell wrote:
> > On Wed, 2005-03-30 at 14:57 -0800, David Brownell wrote:
> > > Quoth rlevell@joe-job.com:
> > > > I think this is connected to a problem people have been reporting on the
> > > > Linux audio lists.  With some USB chipsets, USB audio interfaces just
> > > > don't work.  There are dropouts even at very high latencies.  
> > 
> > Please don't trim cc: lists.  Always use reply-to-all for LKML mail.
> 
> Please don't assume everyone subscribes to LKML, or that
> everything crafted to be threaded more-or-less-correctly
> was really crafted with any kind of "reply" command.  :)

Um, that's exactly why reply-to-all should be used, because not everyone
who posts to LKML subscribes to the list.  Otherwise, you'd either have
to make everyone who posts a question or a bug report subscribe to the
list to see the replies, or place the burden on the responder to keep
track of who wants to be cc'ed and who doesn't.

Beaised, even if you disagree with them, when you post to LKML you abide
by the LKML rules.  It's up to you to know what those are.

Lee

