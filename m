Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRGIQSe>; Mon, 9 Jul 2001 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbRGIQS0>; Mon, 9 Jul 2001 12:18:26 -0400
Received: from viper.haque.net ([66.88.179.82]:28311 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S262682AbRGIQRm>;
	Mon, 9 Jul 2001 12:17:42 -0400
Date: Mon, 9 Jul 2001 12:17:30 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: "Gary White (Network Administrator)" <admin@netpathway.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VMWare crashes
In-Reply-To: <3B49C487.455681FC@netpathway.com>
Message-ID: <Pine.LNX.4.33.0107091216210.1305-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Gary White (Network Administrator) wrote:

> Unable to handle kernel NULL pointer dereference at virtual address 00000070
>  printing eip:
> e1af85e1
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<e1af85e1>]
> EFLAGS: 00013282
> eax: 00000000   ebx: 00000000   ecx: c243e000   edx: 00000000
> esi: d6b2f480   edi: dfe24df4   ebp: dfe24dc0   esp: c243feb0
> ds: 0018   es: 0018   ss: 0018
> Process vmware (pid: 487, stackpage=c243f000)
> Stack: de7aac04 00000000 de7aac00 d6b2fd80 de7aac3c 00000001 dfe212c0 dfe4d400
>        dfe212c0 dfe212c0 d6b2fd80 e1af6f9e dfe24e14 c76f1e00 00003202 de7aac04
>        00000000 de7aac00 d6b2fd80 e1af74e6 de7aac04 c76f1e00 c76f1e00 c0203fe4
> Call Trace: [<c0203fe4>] [<c0203fe4>] [<c011722f>] [<c012eb26>] [<c0106dc3>]
>
> Code: 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 0c 83 c4
>

You'll need to pass teh stuff above through kysymoops to see anything
useful.

I havent had problems running vmware and I usually have it running days
on end.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

