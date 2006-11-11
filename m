Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947079AbWKKEPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947079AbWKKEPI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 23:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947082AbWKKEPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 23:15:08 -0500
Received: from [213.184.169.133] ([213.184.169.133]:12160 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1947079AbWKKEPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 23:15:06 -0500
From: Al Boldi <a1426z@gawab.com>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Sat, 11 Nov 2006 07:15:49 +0300
User-Agent: KMail/1.5
Cc: Arjan van de Ven <arjan@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200611090757.48744.a1426z@gawab.com> <200611110022.52304.a1426z@gawab.com> <20061110133101.4e6cddd3@freekitty>
In-Reply-To: <20061110133101.4e6cddd3@freekitty>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200611110715.49343.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Al Boldi <a1426z@gawab.com> wrote:
> > Arjan van de Ven wrote:
> > > > The problem is not just simple bugs that surface, it's deeper than
> > > > that. Deep structural problems is what plagues 2.6.
> > > >
> > > > Only a focused model may deal with such problems.
> > >
> > > can you at least provide a list of such structural problems?
> > > In fact, why don't you collect them and mail them out (bi)weekly...
> > > that may already do wonders.
> > > Look at what Adrian is doing with the regressions; although the
> > > response isn't 100% people DO pay attention to it.... so maybe if you
> > > post a "structural problems list" people will actually start working
> > > on things.. (and of course you can help too ;)
> >
> > Ok, things like OOM, scheduling, and block-io.
>
> If you want stability don't change these.  But if you think you
> have better heuristics propose them for discussion.

I don't think there is a lack of heuristics, nor is there a lack of 
discussion.  What is needed, is a realization of the problem.

IOW, respective tree-owners need to come to a realization of the state of 
their trees, problem or not.  If it has a problem, that problem needs to be 
fixed or backed out of stable and moved into dev.

> > net looks ok, although I would suggest a redesign for 3.0.
>
> Facts, no vague pronouncements please.

I meant structural OSI compliance.


Thanks!

--
Al

