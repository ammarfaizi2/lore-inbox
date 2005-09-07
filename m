Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVIGKVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVIGKVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVIGKVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:21:07 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:7048 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S1750757AbVIGKVH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:21:07 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kbuild & C++ 
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Wed, 7 Sep 2005 12:17:10 +0200
Message-ID: <809C13DD6142E74ABE20C65B11A2439809C4BF@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kbuild & C++ 
Thread-Index: AcWzkrg+Q41D0zJPSvyl7h3MTl330wAAgHsg
From: "Budde, Marco" <budde@telos.de>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Do you have any *serious* intent to drop 10 *megabytes* worth of
driver
> into the kernel??? (Hint - *everything* in drivers/net/wireless
*totals*
> to only 2.7M).

no, I don't. No every module has to go into the standard kernel :-).

> A Linux device driver isn't the same thing as a Windows device driver
- much of
> a Windows driver is considered "userspace" on Linux, and you're free
to do that
> in C++ if you want.

Well, it is not the first driver I am writing for Linux.
So yes, I do know, what is part of a Linux driver and
what is not.

cu, Marco


