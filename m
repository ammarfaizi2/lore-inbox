Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTIAR1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTIAR1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:27:11 -0400
Received: from law11-f92.law11.hotmail.com ([64.4.17.92]:31244 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263154AbTIARZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:25:21 -0400
X-Originating-IP: [220.224.1.76]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: jmorris@intercode.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor IPSec performance with 2.6 kernels
Date: Mon, 01 Sep 2003 22:55:20 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F92lj1Jwuo8tn00019510@hotmail.com>
X-OriginalArrivalTime: 01 Sep 2003 17:25:20.0631 (UTC) FILETIME=[04F54870:01C370AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is taken from FreeS/Wan HOWTO.

"AES is a new US government block cipher standard, designed to replace the 
obsolete DES. If FreeS/WAN
using 3DES is not fast enough for your application, the AES patch may help.

To date (March 2002) we have had only one mailing list report of 
measurements with the patch applied. It
indicates that, at least for the tested load on that user's network, AES 
roughly doubles IPsec
hroughput."

                   -Kartikey Mahendra Bhatt



>From: James Morris <jmorris@intercode.com.au>
>To: Tom Sightler <ttsig@tuxyturvy.com>
>CC: "Adam J. Richter" <adam@yggdrasil.com>,LKML 
><linux-kernel@vger.kernel.org>
>Subject: Re: Poor IPSec performance with 2.6 kernels
>Date: Thu, 28 Aug 2003 23:40:04 +1000 (EST)
>
>On 28 Aug 2003, Tom Sightler wrote:
>
> > I'm using 3des for the encryption algorithm.
>
>What authentication algorithm (if any) ?
>
>
>- James
>--
>James Morris
><jmorris@intercode.com.au>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________
Need a naukri? Your search ends here. http://www.msn.co.in/naukri/ 50,000 of 
the best jobs!

