Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUEGU1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUEGU1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUEGU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:27:00 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:36302 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263775AbUEGUTs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:19:48 -0400
Message-ID: <409BDD92.7030607@zytor.com>
Date: Fri, 07 May 2004 12:03:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc3] Lindent on arch/i386/kernel/msr.c
References: <50390000.1083882659@dyn318071bld.beaverton.ibm.com> <c7elrc$ddm$1@terminus.zytor.com> <72100000.1083954633@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <72100000.1083954633@dyn318071bld.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> --On Friday, May 07, 2004 12:39:08 AM +0000 "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
> 
>>Please don't apply this right now.  I'm in the middle of making a change to
>>the msr and cpuid modules.
> 
> 
> Sorry about that. I usually remember to cc the maintainers. Of course the one time
> I forget it is actively being worked on.
> 
> I can do a Lindent patch after we are both done. Sounds like our changes won't conflict.
> 

I'll just Lindent it as part of the change.  It's a massive modification 
anyway.

	-hpa
