Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbVLAAJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbVLAAJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVLAAI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:08:58 -0500
Received: from fmr22.intel.com ([143.183.121.14]:50095 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751314AbVLAAIo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:08:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add VT flag to cpuinfo
Date: Wed, 30 Nov 2005 16:08:28 -0800
Message-ID: <7F740D512C7C1046AB53446D372001730615842C@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add VT flag to cpuinfo
Thread-Index: AcX2CP/2SCBPxN8oS1+5lIbCRjJVwQAAfaUw
From: "Dugger, Donald D" <donald.d.dugger@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Shah, Rajesh" <rajesh.shah@intel.com>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 01 Dec 2005 00:08:31.0494 (UTC) FILETIME=[5CFACA60:01C5F60B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi-

As I said, we discussed this internally and the concensus was that
`vmx' was correct.  Especially since this term is used in the
documentation this should be safe.

--
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
Donald.D.Dugger@intel.com
Ph: (303)440-1368 

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Wednesday, November 30, 2005 4:50 PM
>To: Dugger, Donald D
>Cc: Andi Kleen; linux-kernel@vger.kernel.org; Shah, Rajesh; 
>akpm@osdl.org
>Subject: Re: [PATCH] Add VT flag to cpuinfo
>
>On Wed, Nov 30, 2005 at 03:46:09PM -0800, Dugger, Donald D wrote:
>> Andi-
>> 
>> Story of my life (I've had way too many patches that I
>> sent out just a little too late :-)
>
>It might be useful if you could confirm "vmx" is the really
>official name that will continue to be used to describe that feature
>in the future.  We're already stuck with PNI instead of SSE3 and no
>need to make that mistake problem. If VT matches the long term 
>naming better
>it would be a good idea to still rename it.
>
>-Andi
>
