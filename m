Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVBWBZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVBWBZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 20:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVBWBZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 20:25:08 -0500
Received: from fire.osdl.org ([65.172.181.4]:44943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261377AbVBWBY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 20:24:59 -0500
Date: Tue, 22 Feb 2005 17:29:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jdmason@us.ibm.com,
       rich@phekda.gotadsl.co.uk, jgarzik@pobox.com
Subject: Re: [rft/update] r8169 changes in 2.6.x
Message-Id: <20050222172935.30e43270.akpm@osdl.org>
In-Reply-To: <20050222234810.GA17303@electric-eye.fr.zoreil.com>
References: <20050222234810.GA17303@electric-eye.fr.zoreil.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> wrote:
>
> Patch against 2.6.10-rc4:
> - http://www.fr.zoreil.com/~romieu/misc/20050222-2.6.11-rc4-r8169.c-test.patch

There are already a bunch of r8169 patches in Jeff's tree.  The combination
isn't pretty:


patching file drivers/net/r8169.c
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 69.
Hunk #3 FAILED at 79.
Hunk #4 succeeded at 114 (offset 7 lines).
Hunk #5 FAILED at 161.
Hunk #6 FAILED at 175.
Hunk #7 FAILED at 224.
Hunk #8 succeeded at 231 (offset 3 lines).
Hunk #9 succeeded at 248 (offset 7 lines).
Hunk #10 succeeded at 268 (offset 3 lines).
Hunk #11 succeeded at 294 (offset 7 lines).
Hunk #12 succeeded at 300 (offset 3 lines).
Hunk #13 succeeded at 391 (offset 7 lines).
Hunk #14 FAILED at 424.
Hunk #15 succeeded at 468 (offset 3 lines).
Hunk #16 succeeded at 487 (offset 7 lines).
Hunk #17 succeeded at 500 with fuzz 1 (offset 10 lines).
Hunk #18 FAILED at 732.
Hunk #19 FAILED at 767.
Hunk #20 FAILED at 1036.
Hunk #21 succeeded at 1053 with fuzz 2 (offset 19 lines).
Hunk #22 FAILED at 1093.
Hunk #23 FAILED at 1128.
Hunk #24 FAILED at 1140.
Hunk #25 succeeded at 1178 (offset 10 lines).
Hunk #26 succeeded at 1198 with fuzz 1 (offset 19 lines).
Hunk #27 succeeded at 1213 (offset 10 lines).
Hunk #28 succeeded at 1259 (offset 19 lines).
Hunk #29 succeeded at 1261 with fuzz 2 (offset 13 lines).
Hunk #30 succeeded at 1368 (offset 19 lines).
Hunk #31 FAILED at 1576.
Hunk #32 succeeded at 1600 (offset 13 lines).
Hunk #33 FAILED at 1615.
Hunk #34 succeeded at 1683 (offset 26 lines).
Hunk #35 succeeded at 1717 (offset 13 lines).
Hunk #36 FAILED at 1854.
Hunk #37 succeeded at 2042 (offset 24 lines).
Hunk #38 FAILED at 2152.
Hunk #39 succeeded at 2160 (offset 13 lines).
Hunk #40 succeeded at 2187 (offset 24 lines).
Hunk #41 succeeded at 2245 (offset 13 lines).
Hunk #42 FAILED at 2270.
Hunk #43 succeeded at 2293 with fuzz 2 (offset 24 lines).
Hunk #44 succeeded at 2314 (offset 13 lines).
Hunk #45 FAILED at 2349.
Hunk #46 succeeded at 2387 (offset 30 lines).
Hunk #47 succeeded at 2378 (offset 13 lines).
Hunk #48 FAILED at 2391.
Hunk #49 succeeded at 2445 with fuzz 2 (offset 31 lines).
20 out of 49 hunks FAILED -- saving rejects to file drivers/net/r8169.c.rej
