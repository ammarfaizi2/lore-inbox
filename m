Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319136AbSHMSsI>; Tue, 13 Aug 2002 14:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319137AbSHMSsH>; Tue, 13 Aug 2002 14:48:07 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:47587 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S319136AbSHMSsE>; Tue, 13 Aug 2002 14:48:04 -0400
Message-Id: <200208131850.g7DIoxj32332@pimout3-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Tue, 13 Aug 2002 09:50:52 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
       <frankeh@watson.ibm.com>, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208131125240.7411-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208131125240.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 August 2002 02:32 pm, Linus Torvalds wrote:
> On Tue, 13 Aug 2002, Rob Landley wrote:
> > > Having a license that explicitly states that people who
> > > contribute and use Linux shouldn't sue you over it might
> > > prevent some problems.
> >
> > Such a clause is what IBM insisted on having in ITS open source license. 
> > You sue, your rights under this license terminate, which is basically
> > automatic grounds for a countersuit for infringement.
>
> Note that I personally think the "you screw with me, I screw with you"
> approach is a fine one. After all, the GPL is based on "you help me, I'll
> help you", so it fits fine.
>
> However, it doesn't work due to the distributed nature of the GPL. The FSF
> tried to do something like it in the GPL 3.0 discussions, and the end
> result was a total disaster. The GPL 3.0 suggestion was something along
> the lines of "you sue any GPL project, you lose all GPL rights". Which to
> me makes no sense at all - I could imagine that there might be some GPL
> project out there that _deserves_ getting sued(*) and it has nothing to do
> with Linux.

So this is another argument in favor of having the patent addendum be 
separate then.  Software patents as a class are basically evil, and valid 
ones are clearly the exception.  Copyrights are NOT evil (or at least are 
inherently more tightly focused), and valid ones are the rule.

There is also the legal precent of patent pools, which are an established 
legal concept as far as I know.  Joining a patent pool means you license all 
your patents to get a license to all their patents, and bringing a patent 
suit within the pool would violate your agreement and cut you off from the 
pool.  (If I'm wrong, somebody correct me on this please.)

The open source community's problem is that it historically hasn't had the 
entry fee to participate in this sort of arrangement, and solving it on a 
company by company basis doesn't help the community.  These days open source 
has a lot more resources than it used to.

I think Red Hat is actually trying to help on this front by getting patents 
and licensing them for use in GPL code.  By itself, this is not a solution, 
but it could be the seed of one...

Right, at this point I need to go bug a lawyer, I think...

> 		Linus
>
> (*) "GNU Emacs, the defendent, did inefariously conspire to play
> towers-of-hanoy, while under the guise of a harmless editor".

But remember, you can't spell "evil" without "vi"... :)

Rob
