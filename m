Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWCCSNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWCCSNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWCCSNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:13:07 -0500
Received: from spirit.analogic.com ([204.178.40.4]:6155 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750938AbWCCSNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:13:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <44087BF5.90003@gmail.com>
x-originalarrivaltime: 03 Mar 2006 18:13:04.0560 (UTC) FILETIME=[1D8DAB00:01C63EEE]
Content-class: urn:content-classes:message
Subject: Re: Software Emulation Layer
Date: Fri, 3 Mar 2006 13:13:03 -0500
Message-ID: <Pine.LNX.4.61.0603031305140.18102@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Software Emulation Layer
Thread-Index: AcY+7h2zHLd0zwtnRm+b8mO0uyftDw==
References: <44087BF5.90003@gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Marcos Luiggi Lemos Sartori" <marlls1989@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Mar 2006, Marcos Luiggi Lemos Sartori wrote:

> I have an Idea that could be good to you propuse to the Developers.
>
> I think that all unixs most have a universal binarie (kind you compile
> Bash on a BSD and you can run on Linux, Solaris... Without recompile
> it), so my Idea is create a plugable automatic kernel Level emulation
> for aliens binaries, and root threes for the aliens systems libraries
> (such Libc).
>
> And Create a Library Abstraction Layer (kind you have gtk+ on the root
> three from the host System, All aliens Binaries can use the GTK+ from
> Linux) Because you don't need install multiples copies of a same
> Library.
>
> In some time other system will try to copy this scheme, so we will let
> it happen because they will provide us their compatiple plug-in and we
> will provide our to them. Making all unix more compatiple!
>
> Marcos Sartori
>

You mean you are going to create a `pcode` layer and force all
`binaries` to be `pcode`??? Or are you going to force everybody
to rewrite everything in interpreted BASIC? Sorry, it's been
tried by practically every first-year software student until
they learn that the CPU actually fetches CPU-specific
instructions. You change the CPU, you need to change the
instructions. Of course there are those who still think that
Java does what you are planning and that the world is flat.
Anyway, good luck!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
