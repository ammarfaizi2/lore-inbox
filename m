Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbTAKQpk>; Sat, 11 Jan 2003 11:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267283AbTAKQpk>; Sat, 11 Jan 2003 11:45:40 -0500
Received: from fmr01.intel.com ([192.55.52.18]:16577 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267282AbTAKQpj> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 11:45:39 -0500
content-class: urn:content-classes:message
Subject: RE: KIRQ Balance
Date: Sat, 11 Jan 2003 08:54:21 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5647D0F7B@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KIRQ Balance
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK5XOK9FCv6BSVPEdewWABQi2jYqAANGKrQ
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 11 Jan 2003 16:54:21.0768 (UTC) FILETIME=[16BD8C80:01C2B992]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the one we posted (by Nitin) recently. It's a complementary solution to Ingo's random/round-robin interrupt routing, co-existing with it. See Nitin's emails for the patch and details.

Jun

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Saturday, January 11, 2003 2:32 AM
> To: Kamble, Nitin A
> Cc: Linux Kernel
> Subject: Re: KIRQ Balance
> 
> On Mon, Jan 06, 2003 at 11:40:31AM -0800, Kamble, Nitin A wrote:
> > Hi Martin,
> >   Would somebody get a chance to try the kirq patch out? If yes, please
> > let me know, how the patch did on your systems. Did your guys find any
> > issues with it? I will also appreciate more comments.
> 
> Where/What is the kirq patch?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
