Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423856AbWKHWzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423856AbWKHWzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423857AbWKHWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:55:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423856AbWKHWzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:55:19 -0500
Date: Wed, 8 Nov 2006 14:51:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-Id: <20061108145150.80ceebf4.akpm@osdl.org>
In-Reply-To: <1163024531.3138.406.camel@laptopd505.fenrus.org>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>
	<1163024531.3138.406.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 23:22:11 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> > - A while back, akpm made some statements about being worried that the
> > 2.6 kernel is getting buggier
> > (http://news.zdnet.com/2100-3513_22-6069363.html).
> 
> and at this years Kernel Summit actual data

Not true.  70% of surveyed users had hit a new kernel bug.  Of those bugs,
30% remained unresolved.  I don't know what our quality targets are, but I
suggest they're a little higher than that.

> and general consensus showed
> this was unfounded fear;

There you finger the problem.
