Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSIDWQt>; Wed, 4 Sep 2002 18:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSIDWQs>; Wed, 4 Sep 2002 18:16:48 -0400
Received: from zmamail05.zma.compaq.com ([161.114.64.105]:11534 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S315717AbSIDWQs> convert rfc822-to-8bit; Wed, 4 Sep 2002 18:16:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Problem on a kernel driver(SuSE, SMP)
Date: Wed, 4 Sep 2002 15:20:43 -0700
Message-ID: <8C18139EDEBC274AAD8F2671105F0E8E012704DA@cacexc02.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem on a kernel driver(SuSE, SMP)
Thread-Index: AcJUWzXNapCLDshkSEiOqpQ6vzviIQABbzNA
From: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Sep 2002 22:20:43.0770 (UTC) FILETIME=[4F3C2DA0:01C25461]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Cristoph.

It does work fine on a plain 2.4.7 and on any Red Hat kernel versions.

Regards,
Vlad

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Wednesday, September 04, 2002 2:37 PM
> To: Libershteyn, Vladimir
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Problem on a kernel driver(SuSE, SMP)
> 
> 
> On Wed, Sep 04, 2002 at 10:56:00AM -0700, Libershteyn, Vladimir wrote:
> > Hi, Cristoph
> > Attached are two related functions,
> > I don't know if I can attach the files to the message,
> > but I can place them in a message body.
> > Please, let me know
> 
> Except of your failure to handle the return value of 
> down_interruptible
> I can't find any obvious bugs.  Does it work on plain 2.4.7 or redhats
> 2.4.7 rpm?  If so I'd fill a bug report against suses patch 
> collection.
> 
> 
