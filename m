Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUGaSsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUGaSsb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 14:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUGaSsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 14:48:31 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:7172 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261159AbUGaSs3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 14:48:29 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Date: Sat, 31 Jul 2004 11:48:23 -0700
Message-ID: <3689AF909D816446BA505D21F1461AE4C750E8@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Thread-Index: AcR3HykZLlU+0Sn2R/+EhjGH44aOogADvvHA
From: "Walker, Bruce J" <bruce.walker@hp.com>
To: "Andi Kleen" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Jul 2004 18:48:24.0071 (UTC) FILETIME=[F54A6170:01C4772E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, we would very much like to contribute OpenSSI to the main kernel.
However, we aren't quite ready to do that.  For the last couple of years
we have getting the functionality and stability on the 2.4 base.  We are
now ready to first get it working on 2.6 and then clean up the code for
submission either to a 2.6 base or a 2.7 base.

Bruce walker


> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Saturday, July 31, 2004 9:55 AM
> To: Walker, Bruce J
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
> 
> 
> "Walker, Bruce J" <bruce.walker@hp.com> writes:
> > leveraging devfs was quite economic, efficient and has been 
> very stable.
> > I'm not sure who you mean by "that's what WE want".  If you mean the
> > current worldwide users of OpenSSI on 2.4, they are a very 
> happy group
> > with a kick-ass clustering capability.
> 
> [...]
> 
> Do you have plans to contribute any pieces of it to the main kernel? 
> 
> -Andi
> 
> 
