Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTBVME5>; Sat, 22 Feb 2003 07:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbTBVME5>; Sat, 22 Feb 2003 07:04:57 -0500
Received: from usen-43x235x12x234.ap-USEN.usen.ad.jp ([43.235.12.234]:61330
	"EHLO miyazawa.org") by vger.kernel.org with ESMTP
	id <S267023AbTBVME4>; Sat, 22 Feb 2003 07:04:56 -0500
Date: Sat, 22 Feb 2003 21:15:26 +0900
From: Kazunori Miyazawa <kazunori@miyazawa.org>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi-core@linux-ipv6.org, kunihiro@ipinfusion.com
Subject: Re: [PATCH] IPv6 IPSEC support
Message-Id: <20030222211526.2884077a.kazunori@miyazawa.org>
In-Reply-To: <20030222.031326.103246837.davem@redhat.com>
References: <20030222202623.38d41d8a.kazunori@miyazawa.org>
	<20030222.031326.103246837.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003 03:13:26 -0800 (PST)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Kazunori Miyazawa <kazunori@miyazawa.org>
>    Date: Sat, 22 Feb 2003 20:26:23 +0900
> 
>    I also moved the functions for ah, and esp.
> 
> I don't think this is so good idea...
>    
>    As a result of moving IPv6 IPsec functions to net/ipv4, it currently prevents to
>    make IPv6 as a module.
>    
> This is one of the reasons why ah/esp ipv6 should stay under ipv6.
> 

I will fix them and submit patch again.

Thank you,

--Kazunori Miyazawa (Yokogawa Electric Coporation)
