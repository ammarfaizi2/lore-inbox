Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVD2TVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVD2TVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVD2TVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:21:31 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:63199 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262895AbVD2TN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:13:27 -0400
Message-ID: <2944.10.10.10.24.1114802002.squirrel@linux1>
In-Reply-To: <200504291854.LAA26550@emf.net>
References: <2712.10.10.10.24.1114799620.squirrel@linux1>
    (seanlkml@sympatico.ca) <200504291854.LAA26550@emf.net>
Date: Fri, 29 Apr 2005 15:13:22 -0400 (EDT)
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
From: "Sean" <seanlkml@sympatico.ca>
To: "Tom Lord" <lord@emf.net>
Cc: torvalds@osdl.org, mpm@selenic.com, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, April 29, 2005 2:54 pm, Tom Lord said:

> The process should not rely on the security of every developer's
> machine.  The process should not rely on simply trusting quality
> contributors by reputation (e.g., most cons begin by establishing
> trust and continue by relying inappropriately on
> trust-without-verification).  This relates to why Linus'
> self-advertised process should be raising yellow and red cards all
> over the place: either he is wasting a huge amount of his own time and
> should be largely replaced by an automated patch queue manager, or he
> is being trusted to do more than is humanly possible.
>

Ahh, you don't believe in the development model that has produced Linux! 
Personally I do believe in it, so much so that I question the value of
signatures at the changeset level.  To me it doesn't matter where the code
came from just so long as it works.   Signatures are just a way to
increase the comfort level that the code has passed through a number of
people who have shown themselves to be relatively good auditors.  That's
why I trust the code from my distribution of choice.  Everything is out in
the open anyway so it's much harder for a con man to do his thing.

Sean



