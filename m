Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSEMK21>; Mon, 13 May 2002 06:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEMK20>; Mon, 13 May 2002 06:28:26 -0400
Received: from web10408.mail.yahoo.com ([216.136.130.110]:45828 "HELO
	web10408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S311564AbSEMK20>; Mon, 13 May 2002 06:28:26 -0400
Message-ID: <20020513102825.35359.qmail@web10408.mail.yahoo.com>
Date: Mon, 13 May 2002 20:28:25 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4 + preempt patch)
To: kernel <linux-kernel@vger.kernel.org>
Cc: vda@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <200205111737.g4BHbfY02535@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pointer got
> corrupted and now movzbl stumbles over it.
> 
> Bad RAM? Consider memtest86 run overnight.
> --

I did use memtest86 and all test is passed, no errors.
And problem still persists with 2.4.19-pre8-ac2 ; oops
after exiting X 

Now I have to use 2.4.16 ; any way all kernel before
2.4.19-pre2 is normal, I did not test 2.4.19-preX>2
but 2.4.19-pre7-ac4 and 2.4.19-pre8-ac2

sounds a kernel bug to me :-)
Hope that it will soon be fixed.

Regards,

> vda 


=====
Steve Kieu

http://messenger.yahoo.com.au - Yahoo! Messenger
- A great way to communicate long-distance for FREE!
