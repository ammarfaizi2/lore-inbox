Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUBTWgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUBTWgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:36:16 -0500
Received: from main.gmane.org ([80.91.224.249]:18839 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261324AbUBTWgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:36:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: 2.6.3-mm2
Date: Fri, 20 Feb 2004 17:36:10 -0500
Message-ID: <c1624r$d22$1@sea.gmane.org>
References: <20040220014437.0bf6d47f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
In-Reply-To: <20040220014437.0bf6d47f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that include/linux/modsetver.h was removed, which means that I 
can no longer build the madwifi driver. Is there something that's 
supposed to replace this?

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm2/
> 
> - More parport fixes/cleanups from Al Viro
> 
> - Various patches were folded together to make them a bit more logical. 
>   -mm has less than 200 patches for the first time in a long time.  Things
>   are actually slowing down.
> 
> - Added an absolutely gargantuan MIPS update.
> 
> - More CPU scheduler changes.
> 
> - 2.6.3-mm2 builds and runs on x86 and ia64, and compiles on x86_64 and ppc64.


