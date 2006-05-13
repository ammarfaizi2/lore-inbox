Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWEMOnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWEMOnh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWEMOnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:43:37 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:34155 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751127AbWEMOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:43:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4COr52BUnDt3q4Z8pqEN+r4HAirX6Tno/eaTDF/H2S7Vy82Imm1dYGPmOytIaBMw/gNPKnxjznZAgCG6n5a3PRaqQ+ZK59i1+zTgPUGzO9H/0ohNKaDTyWiABFmYZTUWcSNJzafrOZOylMKYPhnsBBcS7FvPCh63UgnLbCp6N94=  ;
Message-ID: <4465F097.9080301@yahoo.com.au>
Date: Sun, 14 May 2006 00:43:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
References: <20060509084945.373541000@sous-sol.org>	<20060509085159.285105000@sous-sol.org>	<20060513052757.59446e03.akpm@osdl.org>	<4465D63F.4000605@yahoo.com.au> <20060513072938.642bf600.akpm@osdl.org>
In-Reply-To: <20060513072938.642bf600.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 

>>Someone should write you a script to go through a patch and flag the
>>most common style mistakes. Have the output formatted to look like
>>you're replying to the mail, and wire it up to your inbox ;)
>>
> 
> 
> Even better, someone should write a coding style document, so people get it
> right from the outset.

I thought that was tried several years back -- I noticed you still
do it manually, so I just assumed that the style document scheme
hadn't worked.

> 
> Clever, aren't I?
> 

Yes... but I don't think it's your cleverness that's the problem ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
