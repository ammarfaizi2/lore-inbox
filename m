Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946769AbWKANjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946769AbWKANjj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946871AbWKANjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:39:39 -0500
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:38748 "EHLO
	outbound2-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1946846AbWKANji convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:39:38 -0500
X-BigFish: V
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: AHCI should try to claim all AHCI controllers
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 1 Nov 2006 21:39:23 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F358602F2D2C0@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AHCI should try to claim all AHCI controllers
Thread-Index: Acb9dDS21p99a1lIRYabiE6KasBmbwARockQ
From: "Conke Hu" <conke.hu@amd.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 01 Nov 2006 13:39:28.0097 (UTC) FILETIME=[26F57510:01C6FDBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Jeff.
But who should be the "Signed-off-by" man when I create a patch and ready for sending it to kernel org?

Best regards,
Conke @ AMD, Inc.



-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: 2006Äê11ÔÂ1ÈÕ 13:11
To: Conke Hu
Cc: torvalds@osdl.org; linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org
Subject: Re: AHCI should try to claim all AHCI controllers

Conke Hu wrote:
> Hi all,
> 	According to PCI 3.0 spec, ACHI's PCI class code is 0x010601,
> and I suggest the ahci driver had better try to claim all ahci
> controllers, pls see the following patch:

BTW, make sure to always include a Signed-off-by: line in every patch.

See http://linux.yyz.us/patch-format.html and 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and 
Documentation/SubmittingPatches (in the kernel source tree).

	Jeff





