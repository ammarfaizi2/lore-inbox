Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUBZS7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUBZS7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:59:41 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:49397 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262923AbUBZS7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:59:38 -0500
Message-ID: <403E4206.5070303@matchmail.com>
Date: Thu, 26 Feb 2004 10:59:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Cherry <cherry@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mm4 (compile stats)
References: <20040225185536.57b56716.akpm@osdl.org> <1077813008.16811.1.camel@cherrytest.pdx.osdl.net>
In-Reply-To: <1077813008.16811.1.camel@cherrytest.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cherry wrote:
> Much better...
> 
> Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
> Warnings/Errors Summary
> 
> Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
>                 (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
> --------------- ---------- -------- -------- -------- -------- --------
> 2.6.3-mm3         1w/0e     5w/0e   146w/ 0e   7w/0e   3w/0e    142w/0e
> 2.6.3-mm3         1w/2e     5w/2e   146w/15e   7w/0e   3w/2e    144w/5e

Yes, much better, especially since it's the same version? ;)
