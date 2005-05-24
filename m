Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVEXWjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEXWjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVEXWjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:39:53 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:27410 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261357AbVEXWhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:37:25 -0400
Date: Tue, 24 May 2005 15:41:57 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050524224157.GA17781@nietzsche.lynx.com>
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au> <1116957953.31174.37.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116957953.31174.37.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 11:05:53AM -0700, Daniel Walker wrote:
> I think Ingo is just confident that in time things will get merged. I
> know that there are some people who don't want/like the RT changes. I'm
> interested to know what people's objections are. So far in this thread
> the only objection that I've feel is valid is the added complexity the
> RT patch would add to Linux.

There's a process to this that has to happen before inclusion. Ingo
outlined that earlier. This patch isn't terribly well known and really
needs to be hammered much harder by a larger community to trigger
breakage.

I think there's a lot of general ignorance regarding this patch, the
usefulness of it and this thread is partially addressing them.

billl

