Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVDUWKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVDUWKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVDUWKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:10:53 -0400
Received: from fmr17.intel.com ([134.134.136.16]:25031 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261386AbVDUWKq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:10:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.10-ac10 oops in journal_commit_transaction
Date: Fri, 22 Apr 2005 06:10:27 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE74270013E8BA0@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.10-ac10 oops in journal_commit_transaction
Thread-Index: AcUiotR0uUA4bTEzT8mH5WC5JM8u3gkG8vCw
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Brice Figureau" <brice+lklm@daysofwonder.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2005 22:10:30.0984 (UTC) FILETIME=[EE8C7480:01C546BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
	We have seen the same oops on the same point.
Can you point to me the URL where the patch is? 
I am not sure which patch should I get.

Thanks
Zou Nan hai 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alan Cox
> Sent: Monday, March 07, 2005 6:59 AM
> To: Brice Figureau
> Cc: Andrew Morton; Linux Kernel Mailing List
> Subject: Re: 2.6.10-ac10 oops in journal_commit_transaction
> 
> FYI Stephen Tweedie has now posted a patch for 2.6.x that ought to fix
> this one.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
