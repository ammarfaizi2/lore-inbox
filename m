Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVHaQUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVHaQUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVHaQUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:20:37 -0400
Received: from office.servervault.com ([216.12.128.136]:4914 "EHLO
	mail1.dulles.sv.int") by vger.kernel.org with ESMTP id S964859AbVHaQUg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:20:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Ran 2.6.13-rc7 for a few days, upgraded to 2.6.13, box crashed in less than 6 hours.
Date: Wed, 31 Aug 2005 12:20:33 -0400
Message-ID: <F8B974E70BDE1745ABB27AF04788FA00BDCD91@mail1.dulles.sv.int>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ran 2.6.13-rc7 for a few days, upgraded to 2.6.13, box crashed in less than 6 hours.
Thread-Index: AcWuR+mDb7QEA7toQeOn/8ptxFBVxQ==
From: "Piszcz, Justin" <jpiszcz@servervault.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did anything critical change from -rc7 to 2.6.13?
I had -rc7 running on three machines for:
> 1 week 
> 3 days
> 2 days
Respectively...

I upgraded to 2.6.13 this morning and only in less than 6 hours the machine locked up, I am not home at the moment so I cannot verify what happened; but nobody was doing anything when the crash occurred.

I will mention that in 2.6.12 the box would lock (and another as well) if you put a 400GB Seagate HDD on a Promise ATA/133 controller; however, 2.6.13-rc7 seemed to have the fix and I have not experienced any problems with it.  However, was some cold reverted back to an earlier version from -rc7 -> 2.6.13, or?

Any comments?

Thanks.

