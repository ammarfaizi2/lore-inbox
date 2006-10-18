Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWJRRP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWJRRP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWJRRP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:15:28 -0400
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:47662 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161237AbWJRRP1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:15:27 -0400
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] x86_64: store Socket ID in phys_proc_id
Date: Wed, 18 Oct 2006 10:15:15 -0700
Message-ID: <5986589C150B2F49A46483AC44C7BCA412D710@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] x86_64: store Socket ID in phys_proc_id
Thread-Index: AcbytgneaxD6hikySBeMzE4SIkpKYAAIhRXg
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
X-OriginalArrivalTime: 18 Oct 2006 17:15:16.0510 (UTC)
 FILETIME=[FB07FBE0:01C6F2D8]
X-WSS-ID: 6928BEAE0C44836267-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen [mailto:ak@muc.de] 

>Can you remind me again what would be fixed by using the initial APIC
ID?
>Just prettier numbering in your lifted APIC IDs case? Or something
>else too?

For easier understanding for socket id and apic id mapping. Also doesn't
care about BIOS how to set the APIC ID.

YH




