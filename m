Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbSKPW7z>; Sat, 16 Nov 2002 17:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbSKPW7z>; Sat, 16 Nov 2002 17:59:55 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16817 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267394AbSKPW7z>; Sat, 16 Nov 2002 17:59:55 -0500
Subject: Re: Disk Performance Issues [AMD Viper plus IDE chipset problems.
	(wrong udma "autodetection")]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miguel S Filipe <m3thos@netcabo.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD6A86C.9090301@netcabo.pt>
References: <3DD6A86C.9090301@netcabo.pt>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Nov 2002 23:33:46 +0000
Message-Id: <1037489626.24769.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 20:19, Miguel S Filipe wrote:
> Hello there,
> 
>   I'm sending this email about a problem with udma settings
> in a TigerMP motherboard, wich supports UDMA 100.
>   I've send it to my distribution mailing list, and several others, to no
> avail, so, has a last resort I send it now to the Linux ML.
>   I'm using pure vanilla linux-2.4.19, and I tried all possible configs
> settings that I though that could affect this problem.

If I remember rightly 2.4.19 doesnt have full support for the AMD
760MP/X although 
