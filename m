Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVLNJVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVLNJVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVLNJVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:21:48 -0500
Received: from ns.firmix.at ([62.141.48.66]:46002 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932223AbVLNJVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:21:47 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Bernd Petrovitsch <bernd@firmix.at>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Andrea Arcangeli <andrea@cpushare.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <439FDF03.50504@aitel.hist.no>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com>
	 <439E8565.3000900@aitel.hist.no> <1134467098.30759.8.camel@tara.firmix.at>
	 <439FDF03.50504@aitel.hist.no>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 14 Dec 2005 10:14:18 +0100
Message-Id: <1134551658.19193.11.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 09:59 +0100, Helge Hafting wrote:
> Bernd Petrovitsch wrote:
> >On Tue, 2005-12-13 at 09:25 +0100, Helge Hafting wrote:
> >  
> >
> >>Salyzyn, Mark wrote:
[...]
> >>Uh, a copyrighted standard?  They are trying to live up to a secret
> >>standard, one they cannot publish?
> >>Don't sound like a standard to me - a standard is something known,
> >>that is the purpose of standardization.
> >>This sounds like "we standardized the voltage for household lamps, but
> >>we won't tell if it is 110V, 220V or something completely different."
> >>I really hope I misunderstood this.
> >
> >s/copyright/patent/ then you will get it probably more right.
> >Given (beautiful and readable) source code, a patent infringement is
> >probably much easier to proove than with disassembled output of gcc-4.x.
> >
> Oh.  So they are infringing already, and just trying to hide it?

ACK - there are so many patents out there (where many them are granted
for software as such, trivial, prior art and/or combinations of them)

> This is so common that it applies to most drivers? :-(

ACK. But this fact is probably not be present in the mind of the average
(none-techie) beancounter, manager or decider.

> >>Standards compliance should never get in the way of open source.
> >>Sure - if the owner modifies the source, then the thing may no longer
> >>comply with the standard.  In some cases even illegal or dangerous. 
> >
> >Propriatory vendors (the larger they are, the more it makes sense) do
> >that all the time without telling their customers/users (usually
> >somewhere hidden within some tools which produce not compliant garbage)
> >and the strategy is called "customer lockin".
> >
> Closed source may lock customers out, not in.  I don't see how an

Yes, also. But I was here refering to software in general, e.g. the
excess of the browser war in creating new HTML entities which were
silently used by the own "WYSIWYG-HTML-Editor" (as if such could exist -
not even in theory).

> open source driver makes it easier for the customer to get away
> from the product.  If the proprietary nvidia driver went open source,
> it still wouldn't work with competing cards - the hw is too different.
> Copying the _hardware_ is still a copyright infringement, and possibly
> also a patent issue.

Hardware-related, ACK.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

