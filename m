Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbTLHQez (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265496AbTLHQbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:31:45 -0500
Received: from havoc.gtf.org ([63.247.75.124]:41130 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265485AbTLHQbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:31:11 -0500
Date: Mon, 8 Dec 2003 11:31:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, mark@symonds.net,
       linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-ID: <20031208163108.GA29407@gtf.org>
References: <20031208165423.555c5783.skraw@ithnet.com> <Pine.LNX.4.44.0312081414150.1289-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312081414150.1289-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 02:15:27PM -0200, Marcelo Tosatti wrote:
> 
> 
> On Mon, 8 Dec 2003, Stephan von Krawczynski wrote:
> 
> > On Mon, 8 Dec 2003 08:17:30 -0200 (BRST)
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > 
> > > Mark,
> > > 
> > > Please try the latest BK tree. There was a known bug in the netfilter code 
> > > which could cause the lockups. 
> > 
> > ...which leads me to the most-simple question: where can I find a changelog for
> > 2.4.23-bkX from www.kernel.org ? Inside ?
> 
> I believe there is nothing which generates 2.4.2x-bk changelogs right now.

It has been automatically generated for a while now ;-)

...
http://www.kernel.org/pub/linux/kernel/v2.4/snapshots/patch-2.4.23-bk5.log
http://www.kernel.org/pub/linux/kernel/v2.4/snapshots/patch-2.4.23-bk6.log
