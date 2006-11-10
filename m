Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965894AbWKJVbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965894AbWKJVbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 16:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966111AbWKJVbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 16:31:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965894AbWKJVbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 16:31:20 -0500
Date: Fri, 10 Nov 2006 13:31:01 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Message-ID: <20061110133101.4e6cddd3@freekitty>
In-Reply-To: <200611110022.52304.a1426z@gawab.com>
References: <200611090757.48744.a1426z@gawab.com>
	<200611102233.30542.a1426z@gawab.com>
	<1163188188.3138.736.camel@laptopd505.fenrus.org>
	<200611110022.52304.a1426z@gawab.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006 00:22:52 +0300
Al Boldi <a1426z@gawab.com> wrote:

> Arjan van de Ven wrote:
> > > The problem is not just simple bugs that surface, it's deeper than that.
> > > Deep structural problems is what plagues 2.6.
> > >
> > > Only a focused model may deal with such problems.
> >
> > can you at least provide a list of such structural problems?
> > In fact, why don't you collect them and mail them out (bi)weekly... that
> > may already do wonders.
> > Look at what Adrian is doing with the regressions; although the response
> > isn't 100% people DO pay attention to it.... so maybe if you post a
> > "structural problems list" people will actually start working on
> > things.. (and of course you can help too ;)
> 
> Ok, things like OOM, scheduling, and block-io.

If you want stability don't change these.  But if you think you
have better heuristics propose them for discussion.

> 
> net looks ok, although I would suggest a redesign for 3.0.

Facts, no vague pronouncements please.


-- 
Stephen Hemminger <shemminger@osdl.org>
