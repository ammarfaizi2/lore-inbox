Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286147AbRLTFyb>; Thu, 20 Dec 2001 00:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286142AbRLTFyV>; Thu, 20 Dec 2001 00:54:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45328 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286146AbRLTFyJ>; Thu, 20 Dec 2001 00:54:09 -0500
Date: Wed, 19 Dec 2001 21:52:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0112192149440.19321-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Dec 2001, Rik van Riel wrote:
> On Tue, 18 Dec 2001, Linus Torvalds wrote:
>
> > The thing is, I'm personally very suspicious of the "features for that
> > exclusive 0.1%" mentality.
>
> Then why do we have sendfile(), or that idiotic sys_readahead() ?

Hey, I expect others to do things in their tree, and I live by the same
rules: I do my stuff openly in my tree.

The Apache people actually seemed quite interested in sendfile. Of course,
that was before apache seemed to stop worrying about trying to beat
others at performance (rightly or wrongly - I think they are right
from a pragmatic viewpoint, and wrong from a PR one).

And hey, the same way I encourage others to experiment openly with their
trees, I experiment with mine.

			Linus

