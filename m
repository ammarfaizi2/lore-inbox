Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUJCHuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUJCHuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 03:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUJCHuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 03:50:46 -0400
Received: from services.exanet.com ([212.143.73.102]:63730 "EHLO
	services.exanet.com") by vger.kernel.org with ESMTP id S267748AbUJCHup convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 03:50:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: PATCH: (as189) Fix incorrect Appletalk DDP multicast address
Date: Sun, 3 Oct 2004 09:50:44 +0200
Message-ID: <F8B4823728281C429F53D71695A3AA1E012729B1@hawk.exanet-il.co.il>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Thread-Index: AcSpF7IvvAPyTjQpT8uB1RX7aEX3wgABU2vg
From: "Shlomi Yaakobovich" <Shlomi@exanet.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Does anyone know what happened to the patch proposed by Alan Stern:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0402.1/1147.html

I looked at the latest sources of 2.4 and 2.6 and this patch was not applied to them. Was there a specific reason, was this patch not tested or found buggy ?  I believe I have encountered a bug in the system I'm running that is related to this, I found this by accident when debugging appletalk, and found out that someone already saw this...

Can this patch be applied to the next kernel build ?  I noticed that it was only for 2.6, I can create a similar patch for 2.4 if needed, I just need to know if there was something wrong with it.

Shlomi


