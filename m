Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130145AbQKKJrE>; Sat, 11 Nov 2000 04:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbQKKJqy>; Sat, 11 Nov 2000 04:46:54 -0500
Received: from [62.172.234.2] ([62.172.234.2]:2728 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S130145AbQKKJqm>;
	Sat, 11 Nov 2000 04:46:42 -0500
Date: Sat, 11 Nov 2000 09:48:14 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: grandsolo@sina.com
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: newbie in kernel
In-Reply-To: <Pine.LNX.4.21.0011110943320.943-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011110947560.943-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Tigran Aivazian wrote:
> 
> The default limit is the 0.25 * physpages but you can change that easily
> by:
> 
> echo 100000 > /proc/sys/threads-max
                ~~~~~~~~~~~~~~~~~~~~~

typo - read /proc/sys/kernel/threads-max

> 
> (haven't you read LKI -- it explains you how to do it:
> 
>   http://www.moses.uklinux.net/patches/lki.sgml
> 
> )
> 
> Regards,
> Tigran
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
