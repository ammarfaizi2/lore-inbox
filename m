Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWIBR5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWIBR5M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 13:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWIBR5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 13:57:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62943 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751255AbWIBR5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 13:57:11 -0400
Subject: RE: Possible gpl problem?
From: David Woodhouse <dwmw2@infradead.org>
To: davids@webmaster.com
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEIJOCAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKKEIJOCAB.davids@webmaster.com>
Content-Type: text/plain
Date: Sat, 02 Sep 2006 10:55:31 -0700
Message-Id: <1157219732.2473.51.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 22:54 -0700, David Schwartz wrote:
> 	So the purpose of the "any third party" requirement is to make sure that
> someone who receives a copy of the offer from a redistributor can acquire
> the source code. It's not so that someone who never received any
> distribution at all can acquire the source code.

I see. So your claim is that when it says "any third party" it doesn't
actually mean "any third party".

> > It doesn't say "any third party who is in possession of a copy of the
> > binary and has a verbatim copy of the original written offer of source".
> > It just says "any third party".
> 
> 	What would be the point of accompanying it with the information regarding
> the offer if that information served no purpose whatsoever? How could you
> enforce an offer when you had no knowledge of who was making the offer and
> what its terms were?

That seems like both question and answer to me; I think you're confusing
yourself.

The "information regarding the offer" is precisely that knowledge about
whom to contact to ask for the source. The point in accompanying
redistributed binaries with that information is so that the recipient of
the binaries knows how to obtain the source code.

That works because "any third party" has a right to approach the
original distributor and ask for the sources.

Of course, that third party does need to _know_ that the source is there
for the asking -- that's why the GPL specifies that the information has
to be passed on to subsequent recipients of the binaries. But that
doesn't mean that the original distributor is only required to provide
source to those who've received binaries -- the GPL says "any third
party".

It's entirely possible for a someone to be entitled to something without
actually being _aware_ of the fact. Your argument seems to be based on
the assumption that that is not possible, as well as a creative
misinterpretation of the fairly unambiguous phrase "any third party".

You keep talking about enforcement, strangely -- as if a right cannot
exist without the direct ability to enforce it. Many people seem to
believe that the only people who can _enforce_ the GPL are those who
hold copyright in the original source; whose work was used by the party
who is now refusing to provide their modified sources.

By your logic, if a right cannot exist without the ability to enforce
it, the only people who are entitled to receive source are the original
copyright-holders -- not even the direct recipients of the binaries,
since they are not in a position to _enforce_ the GPL.

That just doesn't make any sense.

-- 
dwmw2


-- 
VGER BF report: U 0.49756
