Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbTDXIHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDXIHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:07:01 -0400
Received: from [203.197.168.150] ([203.197.168.150]:3340 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S261804AbTDXIG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:06:59 -0400
Message-ID: <3EA79E77.256F7C26@tataelxsi.co.in>
Date: Thu, 24 Apr 2003 13:51:13 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: setting LAA
References: <3EA69279.F14467F9@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any suggestions....

Prasanta Sadhukhan wrote:

> Hi,
>     I was trying to set the LAA through the familiar command of
> "ifconfig tr hw tr 4000deadbeef" but is is giving SIOCSHWADDR: Invalid
> argument.
>
> While going through the ifconfig manpage, I found that the hw classes
> supported are ether, ax25, ARCnet and netcom.
> "tr" is not mentioned.
>
> Is it that setting of LAA in token ring is dispensed from the 2.4
> kernels.

For information, it was supposed to be wroking in 2.0, 2.2 kernels

> If it is not, is there any patch for it?
> Can someone please send me the patch as I tried in the net with no
> success
>
> Thanks & Refgards
> Prasanta
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

