Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUC0RDT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 12:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUC0RDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 12:03:18 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:21910 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261830AbUC0RDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 12:03:17 -0500
Message-ID: <4065B39A.2040003@pacbell.net>
Date: Sat, 27 Mar 2004 09:02:18 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: don <don_reid@comcast.net>
CC: David Woodhouse <dwmw2@infradead.org>,
       Robert Schwebel <robert@schwebel.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de> <40636295.7000008@pacbell.net> <1080297466.29835.144.camel@hades.cambridge.redhat.com> <40644FCA.8000206@pacbell.net> <20040326232328.GA29771@reid.corvallis.or.us>
In-Reply-To: <20040326232328.GA29771@reid.corvallis.or.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>There's a file system protocol used by many digital still cameras,
>>which isn't actually camera-specific.  Not MSFT-specific either.
>>...
> 
> A host driver "USB PTP Storage" would be really nice too.  First
> as a generic camera interface, second to access a gadget with the
> PTP interface.
> 
> (Please embarrass me by saying there already is one, I'll be so happy
> I won't care :-) ).

There isn't one.  There are two.  No need to be embarrassed ... ;)

They're both user-mode drivers.  "gPhoto2", and "jPhoto".  The
author of jPhoto (moi) hasn't had time to update that code in
ages.

- Dave



