Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWHYQuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWHYQuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWHYQuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 12:50:19 -0400
Received: from web83105.mail.mud.yahoo.com ([216.252.101.34]:44205 "HELO
	web83105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422669AbWHYQuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 12:50:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rkEid1NFSH9x35xxQdAHOEnFwW0pvqbzBxdfTWsnyPtLUK6GYWZDyN0AhI+CoF92c7EkQccdOS1WyNXwHruEisv68qip+0teYg3dtLd/gMBwtVysxi3IeqsiOxRArHvk1lyvtkw43qgaefxMs+gdSTC9Y1UzC5xAhH574HbGjb0=  ;
Message-ID: <20060825165017.75036.qmail@web83105.mail.mud.yahoo.com>
Date: Fri, 25 Aug 2006 09:50:17 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: RE: Generic Disk Driver in Linux
To: Arjan van de Ven <arjan@infradead.org>
Cc: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, satinder.jeet@gmail.com
In-Reply-To: <1156493021.3032.2.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 2006-08-24 at 15:21 -0700, Aleksey Gorelov wrote:
> > 
> > --- Arjan van de Ven <arjan@infradead.org> wrote:
> > 
> > 
> > > > > 
> > > > > it'll be easier and quicker to rev engineer 5 more formats than it will
> > > > > be to get the bios thing working ;) And the performance of the bios
> > > > probably true - I'm actually not great fan of originally proposed approach. But, 
> > > > unfortunately, manufactures and vendors still look more to MS. Until market 
> > > > situation changes, there is always a gap...
> > > 
> > > there are only so many different ways to describe raid0.
> > > And those companies aren't going to keep changing that "just because",
> > > changing costs them money, so there is an incentive for them to keep it
> > > as is
> > 
> > Bottom line is - today there is lack of support for it, 
> 
> can you name one?
> (so far all you did was claim this but not name even one)
> 
Here is a good support status
http://linuxmafia.com/faq/Hardware/sata.html
you can start with those who has proprietary binary only drivers.

I should admit though, that dmraid support has improved lately. For instance, 
they recently added Adaptec support, which has not been there before.

