Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWIBFy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWIBFy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 01:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIBFy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 01:54:58 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:48652 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750806AbWIBFy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 01:54:57 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Possible gpl problem?
Date: Fri, 1 Sep 2006 22:54:25 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEIJOCAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <1157174636.2473.22.camel@shinybook.infradead.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 01 Sep 2006 22:49:12 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 01 Sep 2006 22:49:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 2006-08-29 at 06:57 -0700, David Schwartz wrote:
> >
> >     b) Accompany it with a written offer, valid for at least three
> >     years, to give any third party, for a charge no more than your
> >     cost of physically performing source distribution, a complete
> >     machine-readable copy of the corresponding source code, to be
> >     distributed under the terms of Sections 1 and 2 above on a medium
> >     customarily used for software interchange; or,

> > Which, you'll notice, says you must *accompany* the
> > distribution with a
> > written offer. There is no way this offer could be enforced by
> > someone who
> > did not possess it or a copy of it. How would you know who to
> > contact, the
> > amount to pay, and so on?

> > So if you neither possess the binary nor a copy of an
> > offer for the source,
> > you are not entitled to it. At least, that's how I read this.

> That interpretation doesn't seem particularly consistent with the third
> and final option as described in the next paragraph of the GPL:

	Hmm? It's perfectly consistent.

>     c) Accompany it with the information you received as to the offer
>     to distribute corresponding source code.  (This alternative is
>     allowed only for noncommercial distribution and only if you
>     received the program in object code or executable form with such
>     an offer, in accord with Subsection b above.)

	In other words, you must enable the recipient to get the source by passing
your original offer on to them. The recipient, obviously, must be able to
enforce the offer or this makes no sense.

	So the purpose of the "any third party" requirement is to make sure that
someone who receives a copy of the offer from a redistributor can acquire
the source code. It's not so that someone who never received any
distribution at all can acquire the source code.

	This is consistent with the purpose of the GPL as well, which is to make
sure that if you have the binary, you can get the source code. It is not to
ensure that random people can get the source code.

> Unless the party who made the offer of source code is required to extend
> that offer to "any third party" (as in fact is explicitly stated in
> subsection b), how can subsection c work?

	Subsection c works because the person distributing the code passes the
offer on to the recipient so that he is in possession of a copy of the
offer.

> It doesn't say "any third party who is in possession of a copy of the
> binary and has a verbatim copy of the original written offer of source".
> It just says "any third party".

	What would be the point of accompanying it with the information regarding
the offer if that information served no purpose whatsoever? How could you
enforce an offer when you had no knowledge of who was making the offer and
what its terms were?

	DS



-- 
VGER BF report: U 0.499995
