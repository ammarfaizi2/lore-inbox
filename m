Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbSI2VPN>; Sun, 29 Sep 2002 17:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261797AbSI2VPN>; Sun, 29 Sep 2002 17:15:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31499 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261795AbSI2VPJ>;
	Sun, 29 Sep 2002 17:15:09 -0400
Message-ID: <3D976E7F.9070908@pobox.com>
Date: Sun, 29 Sep 2002 17:19:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel panic/exception dump support in 2.5?
References: <Pine.LNX.4.44.0209291640030.594-100000@coredump.sh0n.net> <1033334307.13795.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sun, 2002-09-29 at 21:42, Shawn Starr wrote:
> 
>>It would really be nice if I could capture kernel exceptions/and oopsies
>>on a file, or over a network connection. Redirecting console=lp0 to
>>printer doesnt really let me paste dumps to LKML =)
>>
>>Any solutions? Will we have a way to properly dump kernel failures
>>(exceptions/oopies) somewhere?
> 
> 
> The netdump patch can do this, including the actual kernel image


I hear mention of netdump and netconsole now and again... is anyone 
moving them towards the mainline kernel?  is there a stable URL?

Curious,

	Jeff



