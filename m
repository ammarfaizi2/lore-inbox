Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUFRVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUFRVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFRVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:07:50 -0400
Received: from [213.146.154.40] ([213.146.154.40]:39108 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263881AbUFRVEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:04:00 -0400
Date: Fri, 18 Jun 2004 22:03:51 +0100 (BST)
From: jsimmons@pentafluge.infradead.org
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Rik van Riel <riel@redhat.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, 4Front Technologies <dev@opensound.com>
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <20040618200848.GL20632@lug-owl.de>
Message-ID: <Pine.LNX.4.56.0406182150500.26434@pentafluge.infradead.org>
References: <40D33C58.1030905@am.sony.com>
 <Pine.LNX.4.44.0406181604270.8065-100000@chimarrao.boston.redhat.com>
 <20040618200848.GL20632@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
	0.0 CASHCASHCASH           Contains at least 3 dollar signs in a row
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Jun 2004, Jan-Benedict Glaw wrote:

> On Fri, 2004-06-18 16:05:46 -0400, Rik van Riel <riel@redhat.com>
> wrote in message <Pine.LNX.4.44.0406181604270.8065-100000@chimarrao.boston.redhat.com>:
> > On Fri, 18 Jun 2004, Tim Bird wrote:
> 
> > Since the people benefitting from this work are the
> > embedded developers, it would seem logical that they
> > should bear the cost of this effort, too.
> 
> It's not only all the embedded stuff (where the -tiny tree is a nice
> start!). Remember the bits of the pc98 arch that got ripped these days?
> Remember the CRIS architecture being hopefully out of sync? They're all
> good candidates to profit from such a helper.

The framebuffer is also so far behind. 9 out of 10 patches are 
dropped. The reason being is that everyone is a volunteer doing this in 
there spare time. We don't have the man power, hardware, nor the support 
to do the work that is needed. There are a huge number of drivers that 
could be included but never are. The companies we work for will not 
support the work we do in our spare time because there is no instant 
$$$$$. 

So what is going to be done about this? Will this be the usually hot air?
I seen this discussed before but nothiing ever happens :-( I don't see any 
one setting up to the plate.
