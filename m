Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTFTRA2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTFTQ6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:58:11 -0400
Received: from lhr027c.dhl.com ([198.141.199.27]:45810 "EHLO
	avinms1.bru-hub.dhl.com") by vger.kernel.org with ESMTP
	id S263462AbTFTQyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:54:20 -0400
Message-ID: <3EF33F84.3060801@dhl.com>
Date: Fri, 20 Jun 2003 19:08:20 +0200
From: "Bart SCHELSTRAETE" <Bart.SCHELSTRAETE@dhl.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel <kernel@mousebusiness.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD MP, SMP, Tyan 2466
References: <BB18A5AC.17043%kernel@mousebusiness.com>
In-Reply-To: <BB18A5AC.17043%kernel@mousebusiness.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel wrote:

>Jun 13 16:51:30 grail kernel: kernel BUG at page_alloc.c:100!
>Jun 13 16:51:30 grail kernel: invalid operand: 0000
>Jun 13 16:51:30 grail kernel: CPU:    0
>Jun 13 16:51:30 grail kernel: EIP:    0010:[<c013b0c2>]    Not tainted
>Jun 13 16:51:30 grail kernel: EFLAGS: 00010282
>Jun 13 16:51:30 grail kernel: eax: c1a847ac   ebx: c1a84760   ecx: f7fe6270
>edx: c1a842cc
>Jun 13 16:51:30 grail kernel: esi: 000000b2   edi: 00000000   ebp: 000000b2
>esp: f7861e3c
>Jun 13 16:51:30 grail kernel: ds: 0018   es: 0018   ss: 0018
>

Did you compile this kernel yourself?
I think so, and I think there's something wrong with your compiler.

>Jun 13 16:51:29 grail ifup: grep: relocation error: grep: symbol , version
>GLIBC_2.0 not defined in file libc.so.6 with link time reference
>Jun 13 16:51:29 grail ifup: grep: relocation error: grep: symbol , version
>GLIBC_2.0 not defined in file libc.so.6 with link time reference
>Jun 13 16:51:29 grail network: Bringing up loopback interface:  succeeded
>Jun 13 16:51:29 grail ifup: grep: relocation error: grep: symbol , version
>GLIBC_2.0 not defined in file libc.so.6 with link time reference
>

And here's something wrong with your glibc.........




rgrds,  
          Bart

--
Schelstraete Bart
DHL Aviation

