Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUEMPQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUEMPQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUEMPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:16:08 -0400
Received: from fmr99.intel.com ([192.55.52.32]:55472 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263831AbUEMPP7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:15:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.6-mm2: EFI_VARS=m is broken
Date: Thu, 13 May 2004 08:14:44 -0700
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFEB61@fmsmsx406.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.6-mm2: EFI_VARS=m is broken
Thread-Index: AcQ4+8BU0BtZQ9vhQQO2haUt26JtzwAAQZAg
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>, "Adrian Bunk" <bunk@fs.tum.de>
Cc: "Andrew Morton" <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 May 2004 15:14:44.0945 (UTC) FILETIME=[05DCBC10:01C438FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Duh.  i386 needs to export efi_enabled.  ia64 doesn't as it's a
> #define in linux/efi.h.  Matt T, are you working on EFI for x86_64
> too?  Patch below for i386.

Yep.

matt
