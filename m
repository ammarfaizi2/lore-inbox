Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVEXXoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVEXXoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 19:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVEXXoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 19:44:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55538 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262166AbVEXXoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 19:44:14 -0400
Subject: Re: RT patch acceptance
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Bill Huey <bhuey@lnxw.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
In-Reply-To: <20050524224157.GA17781@nietzsche.lynx.com>
References: <1116890066.13086.61.camel@dhcp153.mvista.com>
	 <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu>
	 <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu>
	 <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu>
	 <4292F074.7010104@yahoo.com.au>
	 <1116957953.31174.37.camel@dhcp153.mvista.com>
	 <20050524224157.GA17781@nietzsche.lynx.com>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 24 May 2005 16:44:04 -0700
Message-Id: <1116978244.19926.41.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 15:41 -0700, Bill Huey wrote:
> On Tue, May 24, 2005 at 11:05:53AM -0700, Daniel Walker wrote:
> > I think Ingo is just confident that in time things will get merged. I
> > know that there are some people who don't want/like the RT changes. I'm
> > interested to know what people's objections are. So far in this thread
> > the only objection that I've feel is valid is the added complexity the
> > RT patch would add to Linux.
> 
> There's a process to this that has to happen before inclusion. Ingo
> outlined that earlier. This patch isn't terribly well known and really
> needs to be hammered much harder by a larger community to trigger
> breakage.

That's a good reason why it should be included. The maintainers know
that as developers there is no way for us to flush out all the bugs in
our code by ourselves. If the RT patch was added to -mm it would have
greatly increased coverage which , as you noted, is needed . Drivers
will break like mad , but no one but the community has all the hardware
for the drivers.


> I think there's a lot of general ignorance regarding this patch, the
> usefulness of it and this thread is partially addressing them.


True .. 

Daniel

