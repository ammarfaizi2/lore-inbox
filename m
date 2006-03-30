Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWC3Sq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWC3Sq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWC3Sq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:46:27 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:49169 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750728AbWC3Sq0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:46:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060330182643.GV27173@skl-net.de>
x-originalarrivaltime: 30 Mar 2006 18:46:21.0208 (UTC) FILETIME=[3CCD3980:01C6542A]
Content-class: urn:content-classes:message
Subject: Re: Float numbers in module programming
Date: Thu, 30 Mar 2006 13:46:20 -0500
Message-ID: <Pine.LNX.4.61.0603301342410.1215@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Float numbers in module programming
Thread-Index: AcZUKjzUnWj8q6TBQfaTOVxXEXyVkQ==
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr> <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com> <20060330182643.GV27173@skl-net.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andre Noll" <maan@systemlinux.org>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "beware" <wimille@gmail.com>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2006, Andre Noll wrote:

> On 08:09, linux-os (Dick Johnson) wrote:
>
>> For instance __all__ real numbers, except for transcendentals, can
>> be represented as a ratio of two integers.
>
> Nope. It was known already to Euklid (300 before christ) that the real
> number sqrt(2) can _not_ be represented as ratio of two integers. Of
> course, sqrt(2) is not transcendental because it is a zero of x^2 -
> 2, a polynomial with integer coefficients.
>
> Andre
> --

Yeah. The correct word was irrational, which is its definition. The
point was that one can do a lot of very accurate work on real numbers
without using the FP unit and the decimal system.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
