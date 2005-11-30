Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVK3XqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVK3XqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 18:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVK3XqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:46:19 -0500
Received: from fmr23.intel.com ([143.183.121.15]:16517 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751260AbVK3XqT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:46:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Add VT flag to cpuinfo
Date: Wed, 30 Nov 2005 15:46:09 -0800
Message-ID: <7F740D512C7C1046AB53446D3720017306158375@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add VT flag to cpuinfo
Thread-Index: AcX2B6xkIiUZxstOQrCCP1UtKNw0ZgAACe+w
From: "Dugger, Donald D" <donald.d.dugger@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Shah, Rajesh" <rajesh.shah@intel.com>,
       <akpm@osdl.org>
X-OriginalArrivalTime: 30 Nov 2005 23:46:10.0874 (UTC) FILETIME=[3DE869A0:01C5F608]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi-

Story of my life (I've had way too many patches that I
sent out just a little too late :-)

No, if you made the same change to the IA32 branch then
that's fine, tnx.

--
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
Donald.D.Dugger@intel.com
Ph: (303)440-1368 

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Wednesday, November 30, 2005 4:42 PM
>To: Dugger, Donald D
>Cc: Andi Kleen; linux-kernel@vger.kernel.org; Shah, Rajesh; 
>akpm@osdl.org
>Subject: Re: [PATCH] Add VT flag to cpuinfo
>
>On Wed, Nov 30, 2005 at 03:34:19PM -0800, Dugger, Donald D wrote:
>> Andi-
>> 
>> Good guess.  We discuessed it and decided that `vmx' was the best
>> term so I'll rework the patch to use that name.
>> 
>> BTW, I don't see any reference to `vmx' in the 2.6.14 tree, is
>> this a change you recently made to your tree?
>
>2.6.14 is ancient. Check 2.6.15rc* 
>Actually I think I changed 32bit too, so your patch is wholly
>obsolete unless you want to rename it.
>
>-Andi
>
