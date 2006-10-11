Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWJKS5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWJKS5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWJKS5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:57:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23182 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932456AbWJKS5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:57:20 -0400
Date: Wed, 11 Oct 2006 11:57:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Remove me from maintainers for serial and mmc
Message-Id: <20061011115709.34975e4b.akpm@osdl.org>
In-Reply-To: <452D34DC.2060704@drzeus.cx>
References: <20061003163611.GA10658@flint.arm.linux.org.uk>
	<452CFCC7.7020508@drzeus.cx>
	<20061011094826.63719621.akpm@osdl.org>
	<452D34DC.2060704@drzeus.cx>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 20:15:56 +0200
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> Andrew Morton wrote:
> > Thanks.  Please send a MAINTAINERS patch.
> >   
> 
> Some practical questions for my new role. I intend to set up a public
> git repository (preferably on kernel.org, but I don't currently know the
> criteria there) as a means to expose my patches.

Send request to the nice people at ftpadmin@kernel.org.  gpg keys will be
needed.  See http://www.kernel.org/faq/#account

> >From what I've observed, the work flow is something like this:
> 
> Have a "for-andrew" and a "for-linus" branch, depending on stuff for -mm
> or the main tree. Moving stuff between the two will be done in my rep
> and after which I send pull requests to LKML.
> 
> This might be a misunderstanding on my part, or for other reasons, not a
> way you wish to work. So I'm open to input on how I should structure things.

That's all ideal - go for it.
