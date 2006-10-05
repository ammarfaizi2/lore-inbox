Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWJEOIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWJEOIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWJEOIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:08:22 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:9732 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751060AbWJEOIV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:08:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 05 Oct 2006 14:08:14.0523 (UTC) FILETIME=[B2D5E8B0:01C6E887]
Content-class: urn:content-classes:message
Subject: Re: [PATCH]suspend support for usblp
Date: Thu, 5 Oct 2006 10:08:00 -0400
Message-ID: <Pine.LNX.4.61.0610051007150.28962@chaos.analogic.com>
In-Reply-To: <200610050904.11944.oliver@neukum.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]suspend support for usblp
thread-index: Acboh7L1cCbDL5bLQbKbZVo26p6fwg==
References: <200610050904.11944.oliver@neukum.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: <vojtech@suse.cz>, "Pavel Machek" <pavel@ucw.cz>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Oct 2006, Oliver Neukum wrote:

> Hi,
>
> this implements suspend support for usblp. According to the CUPS people
> ENODEV will make CUPS retry the job. Thus it is returned in the runtime
> case. My printer survives suspend/resume cycles with it.
>
> 	Regards
> 		Oliver
>
> Signed-off-by: Oliver Neukum <oliver@neukum.name>
>

Good. Glad you got it working!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
