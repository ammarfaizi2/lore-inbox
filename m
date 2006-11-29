Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758043AbWK2Vjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbWK2Vjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758148AbWK2Vjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:39:39 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:23413 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1758043AbWK2Vji convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:39:38 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: PCI: check szhi when sz is 0 when 64 bit iomem bigger than
 4G
Date: Wed, 29 Nov 2006 13:33:12 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA4907252@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI: check szhi when sz is 0 when 64 bit iomem bigger than
 4G
Thread-Index: AccO4SAFWab2XS9TQiKqPnncj84GNAFHDazA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Greg KH" <greg@kroah.com>
cc: "Andrew Morton" <akpm@osdl.org>, "Greg KH" <gregkh@suse.de>,
       "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org,
       myles@mouselemur.cs.byu.edu
X-OriginalArrivalTime: 29 Nov 2006 21:33:13.0980 (UTC)
 FILETIME=[F9ABFBC0:01C713FD]
X-WSS-ID: 697323131WC1736801-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 

>Can you please send me the latest version of this patch, due to all of
>the different changes that it has gone through, I'm a bit confused...

Please check 

http://lkml.org/lkml/2006/11/24/160

for updated version by Andrew.

YH


