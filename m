Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVDNSFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDNSFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVDNSF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:05:29 -0400
Received: from Nazgul.ESIWAY.NET ([193.194.16.154]:35042 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261579AbVDNSDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:03:37 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Marco Colombo <marco@esi.it>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050413194713.GB29327@pegasos>
References: <1113235942.11475.547.camel@frodo.esi>
	 <20050411162514.GA11404@pegasos> <1113252891.11475.620.camel@frodo.esi>
	 <20050411210754.GA11759@pegasos>
	 <Pine.LNX.4.61.0504120034490.27766@Megathlon.ESI>
	 <20050412054002.GB22393@pegasos>
	 <Pine.LNX.4.61.0504121458010.31686@Megathlon.ESI>
	 <20050412184545.GB18557@pegasos> <1113404036.12421.83.camel@frodo.esi>
	 <20050413194713.GB29327@pegasos>
Content-Type: text/plain
Organization: ESI srl
Date: Thu, 14 Apr 2005 20:03:35 +0200
Message-Id: <1113501815.13680.134.camel@frodo.esi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 21:47 +0200, Sven Luther wrote:
> On Wed, Apr 13, 2005 at 04:53:56PM +0200, Marco Colombo wrote:
> > > > This is different. They are not giving the source at all. The licence
> > > > for those object files _has_ to be different. _They_ want it to be
> > > > different.
> > > 
> > > Sure, but in this case, the binary firmware blob is also a binary without
> > > sources. If they really did write said firmware directly as it is, then they
> > > should say so, but this is contrary to everyone's expectation, and a dangerous
> > > precedent to set.
> > 
> > You should realize that any author can publish his work in the form he
> > likes. He's not bound to "everyone's expectation". I see no danger in
> > that.
> 
> I think there may be some limitation of using the GPL as licence in this case
> though, as such behavior may limit its value, and the GPL itself is by no
> means free software.

That GPL isn't the best license in this case (firmware included as
hexstring in the driver source), we already know. But fixing it is up
to the copyright holder. We or GPL face no risk.

Note that the holder does. I'd be interesting if someone produced a
derivative work, such a translation. A translation from the hex form
to some kind of textual formally defined language, such as, say,
assembler, or C. That would be covered by GPL. And would be
distributable under it. Say that the resulting binary is slightly
different. You are _required_ by GPL to provide the source in the
preferred form, this time, preferred by _you_. What if that is C?
Interesting enough. Can the hexstring be reverse-engineered into C,
if it's placed under GPL? Can the copyright holder really prevent that?

Something new to think of. :-)

Have a nice day,
.TM.
-- 
      ____/  ____/   /
     /      /       /                   Marco Colombo
    ___/  ___  /   /                  Technical Manager
   /          /   /                      ESI s.r.l.
 _____/ _____/  _/                      Colombo@ESI.it

