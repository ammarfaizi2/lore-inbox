Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264248AbRFIH6d>; Sat, 9 Jun 2001 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264270AbRFIH6X>; Sat, 9 Jun 2001 03:58:23 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264248AbRFIH6M>; Sat, 9 Jun 2001 03:58:12 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: temperature standard - global config option?
Date: 9 Jun 2001 00:57:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9fsktm$nhv$1@cesium.transmeta.com>
In-Reply-To: <20010608140553.C20944@alcove.wittsend.com> <200106082116.f58LGd2497562@saturn.cs.uml.edu> <20010608191600.A12143@alcove.wittsend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010608191600.A12143@alcove.wittsend.com>
By author:    "Michael H. Warfield" <mhw@wittsend.com>
In newsgroup: linux.dev.kernel
> 
> 	Yes, bits are free, sort of...  That's why an extra decimal
> place is "ok".  Keeping precision within an order of magnitude of
> accuracy is within the realm of reasonable.  Running out to two decimal
> places for this particular application is just silly.  If it were for
> calibrated lab equipment, fine.  But not for CPU temperatures.
> 

Do you want to bet that that is going to remain the case, or are you
just assuming the current state of the art will continue to be used
forever?  That is extremely poor interface design.  Designing
interfaces is NOT the same thing as judging science fairs and
presenting data.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
