Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWIBTmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWIBTmI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 15:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWIBTmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 15:42:08 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:26642 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751437AbWIBTmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 15:42:05 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Possible gpl problem?
Date: Sat, 2 Sep 2006 12:41:39 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEKPOCAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <1157219732.2473.51.camel@shinybook.infradead.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 02 Sep 2006 12:36:38 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 02 Sep 2006 12:36:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, 2006-09-01 at 22:54 -0700, David Schwartz wrote:

> > So the purpose of the "any third party" requirement is to
> > make sure that
> > someone who receives a copy of the offer from a redistributor
> > can acquire
> > the source code. It's not so that someone who never received any
> > distribution at all can acquire the source code.

> I see. So your claim is that when it says "any third party" it doesn't
> actually mean "any third party".

No, it means any third party. That is, you cannot refuse to honor the
agreement on the grounds that the person enforcing it is not someone with
whom you have some previous arrangement or agreement. You cannot
discriminate on the basis of who is trying to enforce the agreement.

If I say "any third party may hire my services for $200/hr", that doesn't
mean that I have to give my services away for free just because it says "any
third party". It would be absurd to argue that if I don't give my services
for free, then I'm re-interpreting "any third party" as "any third party
willing to pay for my services".

What is the point of the offer being written? What is the point of
non-commerical distributors being required to provide a copy? Obviously it's
so that those who receive the binary can enforce the offer.

> > > It doesn't say "any third party who is in possession of a copy of the
> > > binary and has a verbatim copy of the original written offer
> > > of source".
> > > It just says "any third party".
> >
> > 	What would be the point of accompanying it with the
> > information regarding
> > the offer if that information served no purpose whatsoever? How
> > could you
> > enforce an offer when you had no knowledge of who was making
> > the offer and
> > what its terms were?

> That seems like both question and answer to me; I think you're confusing
> yourself.

How so?

> The "information regarding the offer" is precisely that knowledge about
> whom to contact to ask for the source. The point in accompanying
> redistributed binaries with that information is so that the recipient of
> the binaries knows how to obtain the source code.

Right.

> That works because "any third party" has a right to approach the
> original distributor and ask for the sources.

Assuming they know who the original distributor is. Assuming they know that
the offer even exists.

> Of course, that third party does need to _know_ that the source is there
> for the asking -- that's why the GPL specifies that the information has
> to be passed on to subsequent recipients of the binaries. But that
> doesn't mean that the original distributor is only required to provide
> source to those who've received binaries -- the GPL says "any third
> party".

You are confusing what I said. I did not say the distributor is only
required to provide source to those who've recieved binaries. The
distributor cannot say "prove you have the binaries or I will not ship you
source". I am saying that this scheme only *guarantees* that those who
receive binaries can get source. Just because an offer exists that is valid
for any third party, it does not follow that any third party will in fact be
capable of taking advantage of the offer (and thus become entitled to the
thing complying with the terms of the offer gets them).

This scheme does not in fact guarantee that any third party can get the
source code. I'm sure there have been many distributions under this scheme
wherein I have no way to get the source code because I do not even know the
software exists, much less who to contact to get my copy.

The mere existence of an offer does not entitle me to the thing offered.
Only compliance with the terms of the offer entitles you to the thing
offered.

> It's entirely possible for a someone to be entitled to something without
> actually being _aware_ of the fact. Your argument seems to be based on
> the assumption that that is not possible, as well as a creative
> misinterpretation of the fairly unambiguous phrase "any third party".

By this argument, I am entitled to a Whopper because I can buy one. But of
course you are not entitled to it. Just because there exists an offer by
which you could get it, it does not follow that you are entitled to it.

I am entitled to the source code if and only if I can and do exercise the
offer. If I cannot or do not exercise the offer, I am not entitled to the
source code. I may be required to pay for the source code.

> You keep talking about enforcement, strangely -- as if a right cannot
> exist without the direct ability to enforce it. Many people seem to
> believe that the only people who can _enforce_ the GPL are those who
> hold copyright in the original source; whose work was used by the party
> who is now refusing to provide their modified sources.

> By your logic, if a right cannot exist without the ability to enforce
> it, the only people who are entitled to receive source are the original
> copyright-holders -- not even the direct recipients of the binaries,
> since they are not in a position to _enforce_ the GPL.

> That just doesn't make any sense.

By "enforce" I just mean exercise, that is, you are capable of complying
with the terms.

By your understanding, creating the written offer and including a copy of it
serves no purpose whatsoever. The mere existence of the offer is sufficient
in your view.

DS



-- 
VGER BF report: U 0.5
