Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268729AbUI2R17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268729AbUI2R17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUI2R17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:27:59 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:55048 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S268729AbUI2RZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:25:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: patch so cciss stats are collected in /proc/stat
Date: Wed, 29 Sep 2004 12:25:33 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DBFE10@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patch so cciss stats are collected in /proc/stat
Thread-Index: AcSmRb+w1myZlquDSHWjs7oKBOL++gAAzRhQ
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Andreas Haumer" <andreas@xss.co.at>, <arjanv@redhat.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, <mikem@beardog.cca.cpqcorp.net>,
       <marcelo.tosatti@cyclades.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
X-OriginalArrivalTime: 29 Sep 2004 17:25:34.0507 (UTC) FILETIME=[53FC17B0:01C4A649]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Arjan van de Ven wrote:
> > On Wed, 2004-09-29 at 18:29, Miller, Mike (OS Dev) wrote:
> >
> >
> >>>This patch has been reject about half a million times, why 
> are people
> >>>submitting it again and again?
> >>
> >>As I said in my mail, it's a customer driven issue. As long 
> as customers rely on /proc/stat we'll keep trying. You can't 
> tell a customer how he/she should be doing things on their systems.
> >
> >
> > I doubt you have many customers using 2.4.28.... I suspect 
> that by now
> > the majority of people is either using an (ancient) 2.4 
> vendor kernel or
> > a 2.6 kernel. The very low number of reports on lkml about 
> 2.4 seems to
> > confirm that ...
> 
> "25% of accidents are caused by drunken drivers. That means
> 75% of accidents are caused by drivers which did not drink.
> So why keep people complaining about alcohol and driving?"
> 
> Is that what you mean? You must be kidding!
> 
> The majority of _our_ customers are using 2.4.x kernels
> (x beeing in the range from 19 to 28pre3) and it looks like
> it will stay that for quite a while...
> 
> - - andreas
> 
> PS: I know this is somewhat off topic, but I just want to raise
> my voice if I get the impression kernel developers forget about
> the "real world outside". I will shut up in a moment! Thank you!

Thank you, Andreas. I forgot to mention that very salient point!

mikem

> 
> - --
> Andreas Haumer                     | mailto:andreas@xss.co.at
> *x Software + Systeme              | http://www.xss.co.at/
> Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
> A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQFBWum9xJmyeGcXPhERArzMAKCYhHvVvwpFObCzrPby2qY9u9MURQCgrelJ
> BpeZ2tG8zw0po/5ByYKFuZk=
> =RlQc
> -----END PGP SIGNATURE-----
> 
> 
