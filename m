Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268654AbTGIWW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbTGIWW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:22:57 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:30863 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268654AbTGIWWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:22:55 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 9 Jul 2003 15:29:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Daniel Phillips <phillips@arcor.de>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030709222426.GA24923@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307091524240.4625@bigblue.dev.mcafeelabs.com>
References: <20030703023714.55d13934.akpm@osdl.org>
 <Pine.LNX.4.55.0307071007140.4704@bigblue.dev.mcafeelabs.com>
 <20030707193628.GA10836@mail.jlokier.co.uk> <200307082027.13857.phillips@arcor.de>
 <20030709222426.GA24923@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, Jamie Lokier wrote:

> Indeed.  But maybe true (bounded CPU) realtime, reliable, would more
> accurately reflect what the user actually wants for some apps?

Hopefully I'll have a couple of hours free to code and test the
SCHED_SOFTRR idea ;) It's hard to push for a new POSIX definition though :)
Looking at recent posts it seems that this is not the only problem though.
It seems interactivity lowered in the latest versions of the scheduler.
The good news is that Ingo is back on Earth and he'll fix it :)



- Davide

