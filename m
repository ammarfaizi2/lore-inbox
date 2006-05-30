Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWE3XZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWE3XZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWE3XZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:25:25 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:40905 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964816AbWE3XZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:25:24 -0400
Message-ID: <447CD460.6020001@bigpond.net.au>
Date: Wed, 31 May 2006 09:25:20 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net> <447A6D7B.9090302@bigpond.net.au> <447B64BF.4050806@vilain.net> <447B7FD6.6020405@bigpond.net.au> <447BA8ED.3080904@vilain.net> <447BB1C6.9050901@bigpond.net.au> <447CC19D.4020603@vilain.net>
In-Reply-To: <447CC19D.4020603@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 30 May 2006 23:25:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Peter Williams wrote:
> 
>> No, I actually use the gquilt GUI wrapper for quilt 
>> <http://freshmeat.net/projects/gquilt/> and, although I've modified it 
>> to use a generic interface to the underlying patch management system 
>> (a.k.a. back end), I haven't yet modified it to use Stacked GIT as a 
>> back end.  I have thought about it and it was the primary motivation for 
>> adding the generic interface but I ran out of enthusiasm.
>>  
>>
> 
> Hmm, guess the vicar disclaimer was a good one to make.
> 
> Well maybe you'll find the attached file motivating, then.

Maybe.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
