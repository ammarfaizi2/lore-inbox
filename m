Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbUCOXyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUCOXyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:54:24 -0500
Received: from farley.sventech.com ([69.36.241.87]:38347 "EHLO
	farley.sventech.com") by vger.kernel.org with ESMTP id S262856AbUCOXyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:54:15 -0500
Date: Mon, 15 Mar 2004 15:54:14 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
Message-ID: <20040315235414.GE30801@sventech.com>
References: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com> <20040315231705.A23888@infradead.org> <20040315234425.GD30801@sventech.com> <20040315234826.A24238@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315234826.A24238@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Mar 15, 2004 at 03:44:25PM -0800, Johannes Erdfelt wrote:
> > > From looking at both codebases starting from scratch sounds like the
> > > best idea to me..  
> > 
> > What's fatally wrong with the code that's currently available via
> > openib.org?
> 
> Did you actually read it?

The code on openib.org? Yes, I wrote some of it.

I would be the first to say that there are portions that need to be
rewritten, but I definately do not think all or even most of it does.

That's why I was asking what specifically you found fatally wrong with
it. I haven't seen many critiques, so I can only assume it's the same
things I see wrong with it.

> p.s.  if you reply to my mails please keep me in the To line.  Really,
> please don't do any fany reply to group tricks unless people explicitly
> request it in the Mail-Fup header.

If you really want duplicates of all the replies, sure, I'll make an
exception for you.

I don't see why a smarter client, or mail filter, couldn't do the same
thing without depending on the behaviour of the sender.

JE

