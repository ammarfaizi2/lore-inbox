Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWCNQ0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWCNQ0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWCNQ0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:26:52 -0500
Received: from silver.veritas.com ([143.127.12.111]:5416 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751821AbWCNQ0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:26:51 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,191,1139212800"; 
   d="scan'208"; a="35862066:sNHT31516752"
Date: Tue, 14 Mar 2006 16:27:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Andrew Clayton <andrew@rootshell.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
In-Reply-To: <200603141639.38988.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0603141625001.4827@goblin.wat.veritas.com>
References: <1142337319.4412.2.camel@zeus.pccl.info>
 <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com> <200603141639.38988.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Mar 2006 16:26:43.0254 (UTC) FILETIME=[148AE560:01C64784]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Andi Kleen wrote:
> 
> But what happens when you just revert the last hunk (the stub_execve change)?

Still no good: spontaneously rebooted under load after eight minutes.

Hugh
