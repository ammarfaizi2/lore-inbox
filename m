Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTLXD4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 22:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTLXD4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 22:56:53 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:19212 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263178AbTLXD4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 22:56:52 -0500
Date: Wed, 24 Dec 2003 12:00:13 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       <ULMO@Q.NET>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clean up fs/devfs/base.c
In-Reply-To: <20031224034110.GA25709@kroah.com>
Message-ID: <Pine.LNX.4.33.0312241155170.3667-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.4, required 8, AWL,
	BAYES_20, EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Greg KH wrote:

> On Tue, Dec 23, 2003 at 06:38:20PM -0800, Andrew Morton wrote:
> >
> > Now would be a good time for someone to feed the whole thing through indent
> > though.
>
> As much as I enjoy using the devfs code as my "bad coding style"
> example, here's a patch against 2.6.0 that cleans up the devfs code to
> follow the proper kernel coding style.

I think it needs a little bit more than that Greg.

I would like to (will) spend some time on it over the next couple of days.

Ian



