Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUBPBPW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 20:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbUBPBPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 20:15:22 -0500
Received: from may.nosdns.com ([207.44.240.96]:4751 "EHLO may.nosdns.com")
	by vger.kernel.org with ESMTP id S265289AbUBPBPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 20:15:18 -0500
Date: Sun, 15 Feb 2004 18:14:17 -0700
From: Elikster <elik@webspires.com>
X-Mailer: The Bat! (v2.02.3 CE) Personal
Reply-To: Elikster <elik@webspires.com>
Organization: WebSpires Technologies
X-Priority: 3 (Normal)
Message-ID: <121605967.20040215181417@webspires.com>
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re[3]: e1000 problems in 2.6.x
In-Reply-To: <20040215152057.GA582@xeon2.local.here>
References: <20040215152057.GA582@xeon2.local.here>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - may.nosdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - webspires.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Klaus,

   Hmmm..that might explains it, since I don't use NAPI enabled on the E1000 and it works fine without in the 2.4.x series kernels, but under 2.6, it barfs half the time.

Sunday, February 15, 2004, 8:20:57 AM, you wrote:

KD> I have a Tyan-S2665 mobo which has an intergrated
KD> e1000 and I never saw such errors with 2.6 kernels. 

KD> I use it with 100-MBit Full-Duplex in a switched 
KD> private network.

KD> CONFIG_IP_MULTICAST=y
KD> CONFIG_E1000=y
KD> CONFIG_E1000_NAPI=y




-- 
Best regards,
 Elikster                            mailto:elik@webspires.com

