Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSGYRhJ>; Thu, 25 Jul 2002 13:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSGYRhJ>; Thu, 25 Jul 2002 13:37:09 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:772
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S316070AbSGYRhH> convert rfc822-to-8bit; Thu, 25 Jul 2002 13:37:07 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Dave Jones <davej@suse.de>
Subject: Re: MTRR Problems - 2.4.19-rc3
Date: Thu, 25 Jul 2002 13:41:24 -0400
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
References: <200207250303.20809.spstarr@sh0n.net> <20020725150538.U16446@suse.de>
In-Reply-To: <20020725150538.U16446@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207251341.24933.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fair enough, but that doesn't explain the broken MTRR :)

Shawn.


On July 25, 2002 09:05 am, Dave Jones wrote:

> On Thu, Jul 25, 2002 at 03:03:20AM -0400, Shawn Starr wrote:
>  > mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
>  > mtrr: detected mtrr type: Intel
>  > mtrr: no MTRR for e0000000,4000000 found
>  >
>  > Someone explain how an AMD Motherboard is Intel type? ;-)
>
> The Athlon implemented Intel style MTRRs.
> There is no bug there.
>
>         Dave

