Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271372AbTGWXFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 19:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271381AbTGWXFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 19:05:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48392 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271372AbTGWXFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 19:05:22 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [bernie@develer.com: Kernel 2.6 size increase]
Date: 23 Jul 2003 23:12:56 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfn4po$lu3$1@gatekeeper.tmr.com>
References: <20030723195355.A27597@infradead.org> <20030723195504.A27656@infradead.org> <20030723115858.75068294.davem@redhat.com> <20030723200658.A27856@infradead.org>
X-Trace: gatekeeper.tmr.com 1059001976 22467 192.168.12.62 (23 Jul 2003 23:12:56 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030723200658.A27856@infradead.org>,
Christoph Hellwig  <hch@infradead.org> wrote:

| half a megabyte more codesize is a lot if you're based on flash.
| I know you absolutely disliked Andi's patch to make the xfrm subsystem
| optional so we might need find other ways to make the code smaller
| on those systems that need it.  Now I could talk a lot but I'm really
| no networking insider so it's hard for me to suggest where to start.
| I'll rather look at the fs/ issue but it would be nice if networking
| folks could do their part, too.

Actually, perhaps some of the non-functional and misfunctional things
might get fixed first and save the diet for 2.6.5 or so. There is no
lack of things which haven't been quiet ported from 2.4, don't work
right, etc.

I doubt that the people who care most about size are going to be doing
a fast change to 2.6 until the dust settles.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
