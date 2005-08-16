Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbVHPBhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbVHPBhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVHPBhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:37:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965068AbVHPBhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:37:22 -0400
Date: Mon, 15 Aug 2005 18:36:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <1124155352.5764.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0508151836370.3553@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain> 
 <1123809302.17269.139.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>  <1123951810.3187.20.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org>  <1123953924.3187.22.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org>  <1124155000.5764.3.camel@localhost.localdomain>
 <1124155352.5764.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Aug 2005, Steven Rostedt wrote:

> On Mon, 2005-08-15 at 21:16 -0400, Steven Rostedt wrote:
> 
> > Sorry for the late reply, my wife's Grandmother just passed away a few
> > days ago (at 98 years old) and if I went within 6 feet of the computer
> > she would have killed me!
> 
> Just to clearify, "she" as in my wife would have killed me. Not her late
> grandmother.

Thanks for the clarification. We were starting to worry about your family.

		Linus
