Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424434AbWKJVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424434AbWKJVUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 16:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424435AbWKJVUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 16:20:51 -0500
Received: from [212.33.161.175] ([212.33.161.175]:1665 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1424434AbWKJVUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 16:20:50 -0500
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Sat, 11 Nov 2006 00:22:52 +0300
User-Agent: KMail/1.5
Cc: Randy Dunlap <rdunlap@xenotime.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200611090757.48744.a1426z@gawab.com> <200611102233.30542.a1426z@gawab.com> <1163188188.3138.736.camel@laptopd505.fenrus.org>
In-Reply-To: <1163188188.3138.736.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200611110022.52304.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> > The problem is not just simple bugs that surface, it's deeper than that.
> > Deep structural problems is what plagues 2.6.
> >
> > Only a focused model may deal with such problems.
>
> can you at least provide a list of such structural problems?
> In fact, why don't you collect them and mail them out (bi)weekly... that
> may already do wonders.
> Look at what Adrian is doing with the regressions; although the response
> isn't 100% people DO pay attention to it.... so maybe if you post a
> "structural problems list" people will actually start working on
> things.. (and of course you can help too ;)

Ok, things like OOM, scheduling, and block-io.

net looks ok, although I would suggest a redesign for 3.0.


Thanks!

--
Al

