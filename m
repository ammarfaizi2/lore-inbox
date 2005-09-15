Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVIOOQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVIOOQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVIOOQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:16:41 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:42512 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964986AbVIOOQk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:16:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4CA@www.telos.de>
References: <809C13DD6142E74ABE20C65B11A2439809C4CA@www.telos.de>
X-OriginalArrivalTime: 15 Sep 2005 14:16:38.0741 (UTC) FILETIME=[1655B850:01C5BA00]
Content-class: urn:content-classes:message
Subject: Re: How to find "Unresolved Symbols"
Date: Thu, 15 Sep 2005 10:16:38 -0400
Message-ID: <Pine.LNX.4.61.0509151015320.25657@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to find "Unresolved Symbols"
Thread-Index: AcW6ABZ7h/JWKUd8Sh+bB/7WlgLQXA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Budde, Marco" <budde@telos.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Sep 2005, Budde, Marco wrote:

> Hi,
>
> I am working on a larger kernel module.
> This module will be based on a lot of
> portable code, for which I have to implement
> the OS depended code.
>
> At the moment I can compile the complete
> code into a module. Some of OS depended
> code is still missing, but I do not get
> any warnings from kbuild.
>
> When I try to load the module, I can a really
> strange error message:
>
> insmod: error inserting 'foo.o': -795847932 Function not implemented
>
> What does that mean? How can I get a list
> of missing symbols?
>
> cu, Marco
>

Upgrade your module tools, probably also your build procedure.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.53 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
