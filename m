Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVBWUxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVBWUxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVBWUxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:53:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:22612 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261569AbVBWUxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:53:52 -0500
Date: Wed, 23 Feb 2005 20:53:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
In-Reply-To: <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com> 
    <1109187381.3174.5.camel@krustophenia.net> 
    <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Hugh Dickins wrote:
> Please replace by new patch below, which I'm now running through lmbench.

That second patch seems fine, and I see no lmbench regression from it.

Hugh
