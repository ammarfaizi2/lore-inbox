Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272400AbSISTKx>; Thu, 19 Sep 2002 15:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272427AbSISTKx>; Thu, 19 Sep 2002 15:10:53 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:42252 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S272400AbSISTKr> convert rfc822-to-8bit; Thu, 19 Sep 2002 15:10:47 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: TPC-C benchmark used standard RH kernel
Date: Thu, 19 Sep 2002 14:15:34 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E1064038A4698@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: TPC-C benchmark used standard RH kernel
Thread-Index: AcJgD9XDm2XVzqJ4TAK0thG3qKJOLAAAHTVg
From: "Bond, Andrew" <Andrew.Bond@hp.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Sep 2002 19:15:38.0164 (UTC) FILETIME=[EFF96F40:01C26010]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am actually moving in that direction.  I don't know if I will be able to use the same setup or not, but I will post once I get some data.  I can post that I saw X% delta going from 2.4 to 2.5.  I can't help it if anyone extrapolates data from there ;-)

Andy

> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> Sent: Thursday, September 19, 2002 3:06 PM
> To: Bond, Andrew; linux-kernel@vger.kernel.org
> Subject: Re: TPC-C benchmark used standard RH kernel
> 
> 
> > Could we have gotten better performance by patching the 
> kernel?  Sure.  There are many new features in 2.5 that would 
> enhance database performance.  However, the fairly strict 
> support requirements of TPC benchmarking mean that we need to 
> benchmark a kernel that a Linux distributor ships and can support.  
> > Modifications could also be taken to the extreme, and we 
> could have built a screamer kernel that runs Oracle TPC-C's 
> and nothing else.  However, that doesn't really tell us 
> anything useful and doesn't help those customers thinking 
> about running Linux.  The question also becomes "Who would 
> provide customer support for that kernel?" 
> 
> Unofficial results for 2.5 vs 2.4 (or 2.4-redhatAS) would be most
> interesting if you're able to gather them, and still have the
> machine. Most times you can avoid their draconian rules by saying
> "on a large benchmark test that I can't name but you all know what
> it is ..." instead of naming it ... ;-)
> 
> M.
> 
> 
