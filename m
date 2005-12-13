Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVLMJwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVLMJwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVLMJwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:52:25 -0500
Received: from ns.firmix.at ([62.141.48.66]:54155 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932579AbVLMJwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:52:25 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Bernd Petrovitsch <bernd@firmix.at>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Andrea Arcangeli <andrea@cpushare.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <439E8565.3000900@aitel.hist.no>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com>
	 <439E8565.3000900@aitel.hist.no>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 13 Dec 2005 10:44:58 +0100
Message-Id: <1134467098.30759.8.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 09:25 +0100, Helge Hafting wrote:
> Salyzyn, Mark wrote:
[...]
> >For instance, there are reasons, somewhat outside the control of the
> >Hardware Vendor, for binary drivers. Often, in the hopes of achieving

Even if this is the case it is the decision of the hardware vendor to go
that way. The underlying organzation may be equally guilty but that
doens't make the hardware vendor innocent - simply he plays the same
game just with an excuse.

> >standards compliance, Hardware vendors are cornered by legalities over
> >the copyright associated with those standards that ties their hands
> >either from releasing interface documentation or from releasing source
> >code. Yet all these vendors would be overjoyed to have Linux drivers for
> >their Hardware in order to increase the sales of their products.

Then it is up to them to do something.

> Uh, a copyrighted standard?  They are trying to live up to a secret
> standard, one they cannot publish?
> Don't sound like a standard to me - a standard is something known,
> that is the purpose of standardization.
> This sounds like "we standardized the voltage for household lamps, but
> we won't tell if it is 110V, 220V or something completely different."
> I really hope I misunderstood this.

s/copyright/patent/ then you will get it probably more right.
Given (beautiful and readable) source code, a patent infringement is
probably much easier to proove than with disassembled output of gcc-4.x.

> Standards compliance should never get in the way of open source.
> Sure - if the owner modifies the source, then the thing may no longer
> comply with the standard.  In some cases even illegal or dangerous. 

Propriatory vendors (the larger they are, the more it makes sense) do
that all the time without telling their customers/users (usually
somewhere hidden within some tools which produce not compliant garbage)
and the strategy is called "customer lockin".

> But in that case, it is the fault of the owner, not the vendor. The vendor
> can simply say that anyone changing the (distributed) source should get
> their own certification.

At least for (certified) ISDN stacks any change on the source (including
trivial bug fixes) invalidates any official certification AFAIK.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

