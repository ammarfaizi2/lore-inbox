Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSDXI2g>; Wed, 24 Apr 2002 04:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSDXI2f>; Wed, 24 Apr 2002 04:28:35 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:11393 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292857AbSDXI2f>; Wed, 24 Apr 2002 04:28:35 -0400
Date: Wed, 24 Apr 2002 09:51:21 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Huo Zhigang <zghuo@gatekeeper.ncic.ac.cn>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <7754BE2716BF.AAAE8A@gatekeeper.ncic.ac.cn>
Message-ID: <Pine.LNX.4.44.0204240949340.3320-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2002, Huo Zhigang wrote:

>   Hi, all.
>   My cluster go wrong these days. So many times when I "/sbin/reboot" a node, the following message will be displayed on the console.
> 
> >INIT: Switching to runlevel: 6
> >INIT: Send processes the TERM signal
> >Unable to handle kernel NULL pointer dereference
>   
>   What's wrong with my machines?  They are all running linux-2.2.18(SMP-supported) with a kernel module which is a driver of Myricom NIC M3S-PCI64C-2 written by my group.
>   Thank you in advance 8-)
>   
>             Zhigang Huo
>             zghuo@ncic.ac.cn

Have you tried decoding the oops? Have a look at  
linux/Documentation/oops-tracing.txt

	Zwane

-- 
http://function.linuxpower.ca


