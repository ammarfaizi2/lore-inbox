Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422973AbWBOFm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422973AbWBOFm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422974AbWBOFm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:42:29 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:35734 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1422973AbWBOFm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:42:28 -0500
Message-ID: <43F2BF9B.90402@jp.fujitsu.com>
Date: Wed, 15 Feb 2006 14:43:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, kyle@mcmartin.ca
Subject: Re: [PATCH] unify pfn_to_page take3 [0/23]
References: <43F1A753.2020003@jp.fujitsu.com> <20060214213356.02b0caef.akpm@osdl.org>
In-Reply-To: <20060214213356.02b0caef.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>> User-Agent: Thunderbird 1.5 (Windows/20051201)
> 
> uh-oh.
> 
>>  Hi, this is unify-pfn_to_page patch take3. thank you for comments on
>>  previous version.
> 
> I get 100% rejects on all patches due to your email clients's
> space-stuffing, which my client (or at least this version of it) doesn't
> want to un-space-stuff.
> 
> Please resend off-list, using text/plain attachments.
> 
Ouch, very sorry..
I posted them in usual way, but something was wrong.

I'll do soon.

I'm now comparing inlined and out-of-lined pfn_to_page() on ia64 sparsemem.
I'll post it if it is interesting.

-- Kame

