Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUKKQfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUKKQfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbUKKQfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:35:36 -0500
Received: from fmr06.intel.com ([134.134.136.7]:25762 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262279AbUKKQe3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:34:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] pci-mmconfig fix for 2.6.9
Date: Thu, 11 Nov 2004 08:33:53 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E502406EAD01B@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] pci-mmconfig fix for 2.6.9
Thread-Index: AcTHxD1dIvWKB170S7i0ZznDIcHSdAAR51xA
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <akpm@osdl.org>, <greg@kroah.com>,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 11 Nov 2004 16:33:54.0383 (UTC) FILETIME=[3BEDF5F0:01C4C80C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 10, 2004 11:58 PM Andi Kleen wrote:
>Where is it guaranteed that these writes are non posted?

Please refer to section 2.6.1 Flow Control Rules of PCI Express Base
Specs Rev1.0. 

Thanks,
Long
