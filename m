Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbUKWTSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUKWTSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUKWTPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:15:44 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61906 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261478AbUKWTNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:13:45 -0500
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
From: Lee Revell <rlrevell@joe-job.com>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jan De Luyck <lkml@kcore.org>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <41A30D3E.9090506@gmx.de>
References: <200411221530.30325.lkml@kcore.org>
	 <20041122155106.GG2714@holomorphy.com>  <41A30D3E.9090506@gmx.de>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 14:13:43 -0500
Message-Id: <1101237223.6358.10.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 11:13 +0100, Prakash K. Cheemplavam wrote:
> Is xfs known to be broken while preempt is on? (Esp 
> using ck's preemp big kernel lock?)

Minor nitpick:  Ingo wrote the preempt BKL code, not Con.

Lee

