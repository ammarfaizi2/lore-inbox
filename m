Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbTCGU41>; Fri, 7 Mar 2003 15:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261779AbTCGU41>; Fri, 7 Mar 2003 15:56:27 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:63164 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S261777AbTCGU4X>; Fri, 7 Mar 2003 15:56:23 -0500
From: David Lang <david.lang@digitalinsight.com>
To: alx <alexs81@libero.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Fri, 7 Mar 2003 13:05:20 -0800 (PST)
Subject: Re: acx100_pci.o GPL but only binary version
In-Reply-To: <1047068304.1603.14.camel@galileo.homenet.lan>
Message-ID: <Pine.LNX.4.44.0303071304340.1933-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check on the site that you got the binary module from. they are the ones
who need to give you the source.

David Lang

On 7 Mar 2003, alx wrote:

> Date: 07 Mar 2003 21:18:24 +0100
> From: alx <alexs81@libero.it>
> To: LKML <linux-kernel@vger.kernel.org>
> Subject: acx100_pci.o GPL but only binary version
>
>
>
> HI all
> I got this module from the net (binary version)
>
> acx100_pci.o wanna be a linux driver from the TI acx100 chipset.
> but it doesn't work at all!
> - First ifconfig SegFault
> - Second hangs the machine
>
> I did modinfo on this module and I got:
>
>  $ modinfo acx100_pci.o
> filename:    acx100_pci.o
> description: "TI ACX100 WLAN 22Mbps driver"
> author:      "Lancelot Wang"
> license:     "GPL"
>  $
>
> Someone has the source code or know the author ?
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
