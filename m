Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUHWPqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUHWPqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUHWPpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:45:51 -0400
Received: from fmr06.intel.com ([134.134.136.7]:27076 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265973AbUHWPl0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:41:26 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [broken?] Add MSI support to e1000
Date: Mon, 23 Aug 2004 08:41:06 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240619D5A0@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [broken?] Add MSI support to e1000
Thread-Index: AcSG/vEQJLFTgQ+DSIGNq4rN+3++WQCJw/BA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>, "cramerj" <cramerj@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
Cc: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 23 Aug 2004 15:41:09.0424 (UTC) FILETIME=[9C6B8B00:01C48927]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20 Roland Dreier wrote: 
>However, on my Dell box with 865 chipset (lspci below), loading e1000
>(from kernel 2.6.8.1 with this patch applied) with MSI=1 only works
>for a short time (maybe ~1000 e1000 interrupts) before network traffic
>stops.  
>
>Is there something wrong with the patch?  Something wrong with the
>kernel MSI support?  Something wrong with the hardware?

I do not see anything wrong with the patch and the kernel MSI support
because it works for a short time. Ganesh may provide an answer on the 
MSI support in e1000 hardware.

Thanks,
Long
