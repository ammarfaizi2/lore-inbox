Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSHARgK>; Thu, 1 Aug 2002 13:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSHARgJ>; Thu, 1 Aug 2002 13:36:09 -0400
Received: from syndetix.com ([204.134.124.201]:57573 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S316161AbSHARgG>;
	Thu, 1 Aug 2002 13:36:06 -0400
Message-ID: <3D49745B.6070108@zianet.com>
Date: Thu, 01 Aug 2002 11:48:11 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic on Dual Athlon MP
References: <200208011224.g71COrW05657@pc02.e18.physik.tu-muenchen.de> <1028212424.14865.44.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>My board won't even POST with a tg3 card in it. With a newer BIOS it
>
Great, I had plans to put a tg3 card in my dual Athlon box.
Do you know if this is a Tiger board only problem?  I have
the Thunder S2462UNG with just the MP chipset.  How
new of a bios?  I don't plan to use the tg3 card on the box
until 2.4.19 comes out due to the important fixes in it for
the tg3.

>passes the POST test and seems to work with the kernel fixups for the 
>PCI bridges. There are also multiple people who had 3ware problems with
>
I have 2 3ware 7850's on a dual Athlon MP 1900 box and I have
no problems yet with it.  I am about to increase the network to
gigi speed and I hope it has no problems.  Currently this is
with 2.4.18.

>very fast machines, but I gather the latest driver merge fixed that.
>
>So 2.4.9 I'd certainly expect to fail dismally. 2.4.18 ought to be ok as
>should 2.4.19rc4. I run my board with an aacraid scsi and with netgear
>ethernet and its stable. 
>
>Alan
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Steve


