Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWDYPwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWDYPwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWDYPwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:52:13 -0400
Received: from spirit.analogic.com ([204.178.40.4]:14861 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751388AbWDYPwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:52:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <4ae3c140604250827y67675fednba67ffdb67405b87@mail.gmail.com>
X-OriginalArrivalTime: 25 Apr 2006 15:52:10.0541 (UTC) FILETIME=[36757DD0:01C66880]
Content-class: urn:content-classes:message
Subject: Re: Is there an easy way to collect how much memory is used for page cache?
Date: Tue, 25 Apr 2006 11:52:10 -0400
Message-ID: <Pine.LNX.4.61.0604251151310.28817@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is there an easy way to collect how much memory is used for page cache?
thread-index: AcZogDaU4ZYKSrdzRK+oNQQPckbYXA==
References: <4ae3c140604250827y67675fednba67ffdb67405b87@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Apr 2006, Xin Zhao wrote:

> Specifically, how much memory is used to cache data for file systems?
> Any way to measure it?
>
> Thanks!

Get the source for vmstat. In the meantime. `vmstat`.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
