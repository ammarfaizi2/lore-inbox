Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVHWECW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVHWECW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 00:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVHWECW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 00:02:22 -0400
Received: from eastrmmtao04.cox.net ([68.230.240.35]:5362 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750988AbVHWECW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 00:02:22 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: <solt@dns.toxicfilms.tv>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: 3com 3c59x stopped working with 2.6.13-rc[56]
Date: Mon, 22 Aug 2005 22:59:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcWnlwjjW4/yLn95Sdu/aDboJnC5HQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050823040205.NPKQ9925.eastrmmtao04.cox.net@saturn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i tried to boot 2.6.13-rc5-git4 and 2.6.13-rc6-git13 both with the same
> result: my 3com (3c59x driver on 3com 905c) card not working.
> Here is what I saw in the logs.
> Notice the regularity of the log barfs. They continue the same every
10secs.

I'm currently using 2.6.13-rc6-git13 with the 3c95x driver compiled as a
module,
without any issues.  I've tested all of the 2.6.13-* kernels.  One
noticeable
difference, I've been using gcc-3.4.4 and not gcc-4.0.1.

Steve


