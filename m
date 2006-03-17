Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWCQNSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWCQNSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWCQNSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:18:09 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:22671 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932435AbWCQNSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:18:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tQA4OBfVa/L6wwaVfAZ62Eo/nVUH5/+7sJqzYGKcNfhGsnOT8WIQfbr9ROtxJtXDDMZnDrOPvkBQnfjNs0hqXwduwmctWFpqTfG/UUsGGJJk78lmpBm+i5OD+CO3ZOkIIP7vhY24Ptd9Nij3494A7Zbj6aTrqzqBcprhoD0s5y8=  ;
Message-ID: <441AB706.3050408@yahoo.com.au>
Date: Sat, 18 Mar 2006 00:17:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][1/2] sched: sched.c task_t cleanup
References: <200603180004.13967.kernel@kolivas.org> <20060317130721.GB29759@elte.hu>
In-Reply-To: <20060317130721.GB29759@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>Replace all task_struct instances in sched.c with task_t
>>
>>Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 

Goes against kernel style but it is good Ingo style, yes? ;)

I guess it is better to be consistent, other style issues aside.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
