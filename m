Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUAWXTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUAWXTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:19:15 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:36655 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S266737AbUAWXTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:19:12 -0500
Message-ID: <4011AC22.8050903@planet.nl>
Date: Sat, 24 Jan 2004 00:20:02 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95.3
References: <20040123145048.B1082@beton.cybernet.src> <20040123100035.73bee41f.jeremy@kerneltrap.org> <20040123151340.B1130@beton.cybernet.src> <001b01c3e1ca$26101f20$1e00000a@black> <20040123163008.B1237@beton.cybernet.src> <1074882836.20723.4.camel@minerva>
In-Reply-To: <1074882836.20723.4.camel@minerva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Reppert wrote:

>snip
>  
>

>Many people have been using gcc-3.2 or later to build kernels, and I
>haven't really heard of any problems with this, at least on i386. I
>personally have used 3.2.2 and 3.3.2 (well, with Debian's patches) and
>haven't had any weirdness with 2.6 or 2.4. ISTR there being arches that
>need 3.x to compile, but I could be mistaken.
>
>2.95.3 is definitely the *oldest* compiler you'd want to use, and pretty
>much skip between that and 3.2.
>
>Matt
>  
>
Same here. I've been using gcc3.2.0 and beyond currently 3.3.2 since the 
day they were released and never had any big issues. I would recomend 
using gcc 3.3.2 since it improves performance when using optimizations 
quite a bit as far as I can remember the statistics.

Stef
