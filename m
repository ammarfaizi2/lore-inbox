Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVGOTWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVGOTWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVGOTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:22:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42467 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261678AbVGOTTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:19:48 -0400
Subject: Re: Kernel Bug Report
From: Lee Revell <rlrevell@joe-job.com>
To: linuxtwidler@gmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050715140411.28a30e55@localhost>
References: <20050715140411.28a30e55@localhost>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 15:19:50 -0400
Message-Id: <1121455191.12420.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 14:04 -0500, Lee wrote:
> [20975.978911] PREEMPT SMP DEBUG_PAGEALLOC
> [20976.029194] Modules linked in: vmnet vmmon nvidia
> [20976.090907] CPU:    695757158
> [20976.090909] EIP:    0060:[<c0119ed8>]    Tainted: P      VLI

Please reproduce the bug without these proprietary modules loaded.  And
make sure to include the stack trace.

Lee

