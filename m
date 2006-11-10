Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946710AbWKJPQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946710AbWKJPQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946708AbWKJPQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:16:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4101 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1946710AbWKJPQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:16:30 -0500
Date: Fri, 10 Nov 2006 15:15:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-ID: <20061110151555.GB7708@ucw.cz>
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com> <1163024531.3138.406.camel@laptopd505.fenrus.org> <9a8748490611081440u6ba6c541h1038ac1e530e2839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611081440u6ba6c541h1038ac1e530e2839@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >but if you do this you just end up with a bigger 
> >backlog so that the
> >next one will even be more unstable due to a extreme 
> >high change rate.
> >
> Only if people continue to work on new stuff during the 
> "bug fixing only" cycle.
> If we manage to get everyone focused on bug fixing only 
> for the entire
> cycle the backlog won't be growing (much).

But neither you, nor andrew, nor linus has power to stop development
like that... (nor would it be good idea)

							Pavel
-- 
Thanks for all the (sleeping) penguins.
