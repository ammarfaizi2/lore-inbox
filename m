Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSJaDKE>; Wed, 30 Oct 2002 22:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265136AbSJaDKE>; Wed, 30 Oct 2002 22:10:04 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:47116 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265134AbSJaDKD>; Wed, 30 Oct 2002 22:10:03 -0500
Date: Thu, 31 Oct 2002 12:16:09 +0900 (JST)
Message-Id: <20021031.121609.71851601.yoshfuji@linux-ipv6.org>
To: davem@redhat.com
Cc: boissiere@adiglobal.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5] October 30, 2002
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20021030.184443.87162307.davem@redhat.com>
References: <20021030.143615.10738219.davem@redhat.com>
	<20021031.114832.59687399.yoshfuji@linux-ipv6.org>
	<20021030.184443.87162307.davem@redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: ,!^C1nUj;HDn\o}#MDnZW<|oj*]iIB/>/Rj|xZ=D=hBIY#)lQ,$n#kJvDg7at|p;w0^8&4_
 OS17ezZP7m/LlFJYPF}FdcGx!,qBM:w{Ub2#M8_@n^nYT%?u+bwTsqni(z5
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021030.184443.87162307.davem@redhat.com> (at Wed, 30 Oct 2002 18:44:43 -0800 (PST)), "David S. Miller" <davem@redhat.com> says:

>    > We told you several times how this USAGI patch is not currently in an
>    > acceptable form and needs to be reimplemented via the routing code.
>    
>    Yes, but I think
>      - integrate our code to your tree
>    then
>      - reimplement (re-design)
>    is better way to go forward.
>    
> Absolutely not, we do not put improperly architected code into the
> tree first then clean it up later.

That patch do NOT change current architecture so above is unfair.

It would be ok to say "we do not put code into the part of 
improperly architected code in the tree then clean it up later."

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
