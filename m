Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUA3HeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 02:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUA3HeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 02:34:17 -0500
Received: from fmr99.intel.com ([192.55.52.32]:5799 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S266397AbUA3HeQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 02:34:16 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Can't boot a 2.6 kernel..
Date: Thu, 29 Jan 2004 23:34:09 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE90C@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Can't boot a 2.6 kernel..
Thread-Index: AcPmsA3MuDFnKXUBRvKvLA/5WTUkJQAUkHwQ
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Thomas Davis" <tadavis@lbl.gov>, "Burton Windle" <bwindle@fint.org>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jan 2004 07:34:09.0438 (UTC) FILETIME=[72DB03E0:01C3E703]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> CONFIG_MATH_EMULATION=y
> CONFIG_MTRR=y
> CONFIG_EFI=y
> CONFIG_BOOT_IOREMAP=y
> 
> next.

Can you disable CONFIG_EFI to make sure that isn't the culprit?  

It shouldn't, but if it does please let me know...

thanks,
matt
