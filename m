Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSFKHzT>; Tue, 11 Jun 2002 03:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSFKHzS>; Tue, 11 Jun 2002 03:55:18 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:15836 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316898AbSFKHzR>; Tue, 11 Jun 2002 03:55:17 -0400
Date: Tue, 11 Jun 2002 09:26:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth 'depredation'
In-Reply-To: <3D05AA6E.mailKB1BHA1W@viadomus.com>
Message-ID: <Pine.LNX.4.44.0206110924370.17198-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, DervishD wrote:

>     IMHO, the IP layer (well, in this case the TCP layer) should
> distribute the bandwidth (although I don't know how to do this), and
> the kernel seems to be not doing it.
> 
>     I don't know if this is the intended behaviour or even if this is
> a kernel fault or not, but I think that is not good ;)

QoS (CONFIG_NET_SCHED)?

-- 
http://function.linuxpower.ca
		

