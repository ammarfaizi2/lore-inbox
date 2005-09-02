Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbVIBV6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbVIBV6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVIBV6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:58:41 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:48066 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1161078AbVIBV6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:58:41 -0400
Message-ID: <4318CB11.8060704@namesys.com>
Date: Fri, 02 Sep 2005 14:58:41 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050902003915.GI3657@stusta.de>
In-Reply-To: <20050902003915.GI3657@stusta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>4Kb kernel stacks are the future on i386, and it seems the problems it
>initially caused are now sorted out.
>
>Does anyone knows about any currently unsolved problems?
>
>I'd like to:
>- get a patch into on of the next -mm kernels that unconditionally 
>  enables 4KSTACKS
>- if there won't be new reports of breakages, send a patch to
>  completely remove !4KSTACKS for 2.6.15
>
>In -mm, Reiser4 still has a dependency on !4KSTACKS.
>I've mentioned this at least twice to the Reiser4 people, and they 
>should check why this dependency is still there and if there are still 
>stack issues in Reiser4 fix them.
>
>If not people using Reiser4 on i386 will have to decide whether to 
>switch the filesystem or the architecture...
>
>cu
>Adrian
>
>  
>
Can you wait just one month after we get in for this? Or even 2 weeks.
vs needs a weekend, etc.....
