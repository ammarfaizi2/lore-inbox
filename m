Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWE1RjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWE1RjN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWE1RjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:39:13 -0400
Received: from dvhart.com ([64.146.134.43]:29583 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750816AbWE1RjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:39:12 -0400
Message-ID: <4479E034.2060003@mbligh.org>
Date: Sun, 28 May 2006 10:39:00 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: rc5-git1 and later fail to boot on x86_64
References: <4479BC92.1090900@mbligh.org> <20060528151331.GB2984@redhat.com>
In-Reply-To: <20060528151331.GB2984@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sun, May 28, 2006 at 08:06:58AM -0700, Martin J. Bligh wrote:
>  > plain -rc5 seems fine. Double checking this isn't a machine issue, but
>  > it seems to boot the older kernels just fine.
>  > 
>  > good boot is here: http://test.kernel.org/abat/33283/debug/console.log
>  > for comparison
> 
> If rc5 vs rc5-git1 shows a difference in behaviour for you, something
> is seriously wrong somewhere, as git1 only contained a single arch/s390 patch.

Humpf. must be a machine change then. No idea why it still boots fine to
the older kernels though ... ;-(

Thanks,

M.

