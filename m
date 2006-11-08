Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161697AbWKHTQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161697AbWKHTQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161698AbWKHTQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:16:36 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:6993 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1161697AbWKHTQf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:16:35 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Date: Wed, 8 Nov 2006 11:15:59 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071B7@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] PCI: check szhi when sz is 0 for 64 bit pref mem
Thread-Index: AccDadIk0R57TCB4Rjyv3hfefS0pJAAAF/lw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, ebiederm@xmission.com
cc: "Greg KH" <gregkh@suse.de>, "Andi Kleen" <ak@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Nov 2006 19:16:00.0693 (UTC)
 FILETIME=[53935650:01C7036A]
X-WSS-ID: 694CF37A1X41977079-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 

>I've basically given up in exhaustion on that patch.  Maybe when I have
a
>burst of extra energy I'll go back and take the time to understand it,
>or maybe when Greg comes back he'll save me.

Please 
http://lkml.org/lkml/2006/11/6/341

that would be more clean.

Thanks

Yinghai Lu





