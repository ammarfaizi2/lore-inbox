Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVK3NSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVK3NSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVK3NSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:18:30 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:14 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751214AbVK3NS3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:18:29 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <eab8d9e30511300459j695ed942n@mail.gmail.com>
X-OriginalArrivalTime: 30 Nov 2005 13:18:26.0636 (UTC) FILETIME=[8C45C8C0:01C5F5B0]
Content-class: urn:content-classes:message
Subject: Re: 3C905C-TX
Date: Wed, 30 Nov 2005 08:18:26 -0500
Message-ID: <Pine.LNX.4.61.0511300813190.18193@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 3C905C-TX
Thread-Index: AcX1sIxMFUgjomFWRra3MQWJ7ti6gg==
References: <eab8d9e30511300459j695ed942n@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-1?Q?Daniel_H=F6hnle?= <hoehnle.dan@googlemail.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, <andrewm@uow.edu.au>,
       <netdev@oss.sgi.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Nov 2005, [iso-8859-1] Daniel Höhnle wrote:

> Hello i have Suse Linux 9.3 and a 3Com 3C905C-TX Networkcard. But she
> don't works. Where can I get a Driver??? Or give it a Dokumentation
> how I can make the Driver??
>
> Thanks
> Daniel Höhnle

The 3c59x driver should work for this device. If it's real
new, you may have to add its ID to the structure at line
3365 in 3x59x.c or contact the maintainer.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
