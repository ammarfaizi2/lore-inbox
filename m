Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWE2DJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWE2DJt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 23:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWE2DJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 23:09:49 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:32148 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751119AbWE2DJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 23:09:48 -0400
Message-ID: <447A65EA.9020705@vilain.net>
Date: Mon, 29 May 2006 15:09:30 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au>
In-Reply-To: <447A3292.5070606@bigpond.net.au>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

>>This is correct.  Basically I read the LARTC.org (which explains Linux
>>network schedulers etc) and the description of the Token Bucket
>>Scheduler inspired me to write the same thing for CPU resources.  It was
>>originally developed for the 2.4 Alan Cox series kernels.  The primary
>>[...]
>>I most recently described this at http://lkml.org/lkml/2006/3/29/59, a
>>lot of that thread is probably worth catching up on.
>>[...]
>>    
>>
>Have you considered adding an implementation of these schedulers to 
>PlugSched?
>  
>

No, I haven't; I'd be happy to do so, given appropriate pointers to a
codebase I can produce commits for.  Is there a public git tree for the
patches, or a series of split out patches?  I see only combined patches
on the SourceForge site.

Sam.
