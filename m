Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265450AbTLHQu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTLHQuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:50:02 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:23451 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265066AbTLHQrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:47:11 -0500
Date: Mon, 8 Dec 2003 11:34:17 -0500
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Larry McVoy <lm@bitmover.com>, Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031208163417.GA17670@pimlott.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com> <20031206141300.GA13372@pimlott.net> <20031206175041.GD28765@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206175041.GD28765@work.bitmover.com>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 09:50:41AM -0800, Larry McVoy wrote:
> On Sat, Dec 06, 2003 at 09:13:00AM -0500, Andrew Pimlott wrote:
> > It might be true that Sun's misdeed perpetually voids their license
> > to XYZ.  
> 
> That's a good question, it's not clear what the answer to that is.  I reread
> the GPL and I don't see where it spells out what happens if you try and cheat.

FWIW, here's what RMS said:

    Misusing a GPL-covered program permanently forfeits the right to
    distribute the code at all. 

    http://linuxtoday.com/news_story.php3?ltsn=2000-09-05-001-21-OP-LF-KE

> > Your comparisons to the SCO case are far-fetched.  In part because
> > of what I said above (your idea of "viral" is divorced from
> > reality)
> 
> In copyright law, yes.  Contract law is a bit different.  Linus and
> you yanked me back into copyright law and you're right that SCO can't
> claim rights to Linux, they don't own it.  But isn't it true that if
> the Unix license they have with IBM (actually more likely Sequent) is a
> contract then that contract could extend to anything that was originally
> written in the context of Unix, even if 100% of was written by Sequent
> and removed from Unix and ported to Linux?

I guess I can't disagree in principle that a contract could cross
almost any boundary.  But it seems vanishingly unlikely that anyone
(not to speak of IBM) would agree to a contract with such
boundary-piercing powers as SCO claims.  For this reason, I don't
think that even the most bold claims for the GPL's virulence help
SCO one bit.  On the contrary, any intelligent discussion of
boundaries can only undermine SCO's nonsensical case.

I agree with you about the importance of figuring out where the
boundaries lie.  I also wish the FSF would get more involved in this
debate, but I have to say, they seem to be avoiding the hard
questions, perhaps because they're afraid to say anything that will
restrict them later.  The best statement I think I've read from them
is

    http://www.gnu.org/licenses/gpl-faq.html#GPLInProprietarySystem

which introduces an "arms length" standard.

> And if it is, which I believe to be true, and if you wrote a new widget
> that was originally done in the context of that program but now wanted
> to put that widget someplace else and the widget removed all references
> to the original program, do I still have any contractially based rights
> to that widget?

For me, this doesn't pass the giggle test.

> Nothing in law is black and white, it's all sorted out in caselaw
> typically.  But as far as I can tell there has to be some way to limit
> the influence of a contract or a license or otherwise everything that
> ran on a GPLed kernel would be GPLed (the HURD is a GPLed kernel, right?
> How much you want to bet that the FSF is not going to try and make the
> claim that userland has to be GPLed?)

They seem to have waived that claim, at least, by deeming system
calls "arms length" communication.

Andrew
