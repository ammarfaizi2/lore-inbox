Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWE2VRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWE2VRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWE2VRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:17:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:6293 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751310AbWE2VRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:17:03 -0400
Message-ID: <447B64BF.4050806@vilain.net>
Date: Tue, 30 May 2006 09:16:47 +1200
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
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net> <447A6D7B.9090302@bigpond.net.au>
In-Reply-To: <447A6D7B.9090302@bigpond.net.au>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

>Yes, but not yet publicly available.  I use quilt to keep the patch 
>series up to date and do the change as a relatively large series (30 or 
>so) to make it easier for me to cope with changes in the kernel.  When I 
>do the next release I'll make a tar ball of the patch series available.
>
>Of course, if your eager to start right away I could make the 
>2.6.17-rc4-mm1 one available?
>  
>

Well a piecewise patchset does make it a lot easier to see what's going
on, especially if it's got descriptions of each patch along the way. 
I'd certainly be interested in having a look through the split out patch
to see how namespaces and this advanced scheduling system might
interoperate.

Sam.
