Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbRFGRCd>; Thu, 7 Jun 2001 13:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbRFGRCX>; Thu, 7 Jun 2001 13:02:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:11256 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261988AbRFGRCM>; Thu, 7 Jun 2001 13:02:12 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3397.991927659@ocs4.ocs-net> 
In-Reply-To: <3397.991927659@ocs4.ocs-net> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Jun 2001 18:01:39 +0100
Message-ID: <7192.991933299@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
> Russell King <rmk@arm.linux.org.uk> wrote:
> > supply kernel binary images as long as they make available the source
> > code to the people they supply the kernel binary to, and no more.

> GNU General Public License Version 2, June 1991.  Section 3(b) says
> "any third party", not just customers.

It does indeed. Pick any three words and take them out of context, however, 
and the result is utterly meaningless.

The paragraph from which you took those words is listed as one of three
_alternatives_. One of the alternatives does not require that the source be
made available to "any third party".

> Nothing in the GPL restricts the source being supplied to "the people
> they supply the kernel binary to, and no more".

If the source is not distributed with the binary, you are correct.
If the source _is_ distributed with the binary, you are wrong. See option (a) below:

GPL>  3. You may copy and distribute the Program (or a work based on it,
GPL> under Section 2) in object code or executable form under the terms of
GPL> Sections 1 and 2 above provided that you also do one of the following:
GPL> 
GPL>     a) Accompany it with the complete corresponding machine-readable
GPL>     source code, which must be distributed under the terms of Sections
GPL>     1 and 2 above on a medium customarily used for software interchange; or,
GPL> 
GPL>     b) Accompany it with a written offer, valid for at least three
GPL>     years, to give any third party, for a charge no more than your
GPL>     cost of physically performing source distribution, a complete
GPL>     machine-readable copy of the corresponding source code, to be
GPL>     distributed under the terms of Sections 1 and 2 above on a medium
GPL>     customarily used for software interchange; or,
GPL> 
GPL>     c) Accompany it with the information you received as to the offer
GPL>     to distribute corresponding source code.  (This alternative is
GPL>     allowed only for noncommercial distribution and only if you
GPL>     received the program in object code or executable form with such
GPL>     an offer, in accord with Subsection b above.)


I may choose option (a). Which does not oblige me to give source to a third
party.

You can ship source with the binaries, _OR_ you must make sure the source is 
available to all third parties. You don't have to do both.

--
dwmw2


