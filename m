Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTEXLdQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 07:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTEXLdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 07:33:15 -0400
Received: from mail0.ewetel.de ([212.6.122.10]:57067 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264051AbTEXLdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 07:33:14 -0400
To: linux-kernel@vger.kernel.org
Cc: Willy Tarreau <willy@w.ods.org>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <20030523203017$0e66@gated-at.bofh.it>
References: <20030523085010$1ac2@gated-at.bofh.it> <20030523180021$109a@gated-at.bofh.it> <20030523203017$0e66@gated-at.bofh.it>
Date: Sat, 24 May 2003 13:46:20 +0200
Message-Id: <E19JXTg-0000HO-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003 22:30:17 +0200, Willy Tarreau wrote in lkml:

> By this time, there will be more and more people leaving vanilla kernel for
> their machines, and using them only as a base to apply -aa, -ac, -jam, -wolk,
> -** + sf.net/* + who_knows_what, and I find it a shame.

I think you overestimate the number of aic7xxx users. It's not like
99% of all 2.4 users need the driver.

-- 
Ciao,
Pascal
