Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSEQKWs>; Fri, 17 May 2002 06:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315548AbSEQKWr>; Fri, 17 May 2002 06:22:47 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:41639 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S315547AbSEQKWq>; Fri, 17 May 2002 06:22:46 -0400
Date: Fri, 17 May 2002 13:21:48 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Andre LeBlanc <ap.leblanc@shaw.ca>
cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: No Network after Compiling, 2.4.19-pre8 under Debian Woody (Long
 Message)
In-Reply-To: <000c01c1fba2$1779da60$2000a8c0@metalbox>
Message-ID: <Pine.GSO.4.21.0205171314360.12593-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Andre LeBlanc wrote:

> Heres the ifconfig before pinging:
> 
> eth0 Link encap:Ethernet HWaddr 00:E0:29:94:CA:BC
> 
> UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
> 
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> 
> TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
> 
> collisions:0 txqueuelen:100
> 
> RX bytes:0 (0.0 b) TX bytes:2052 (2.0 KiB)
> 
> Interrupt:5
> 

Why your IP address doesn't show up above? Is this intentional?
What about the other rtl8139 card reported at irq 11? Is it working?

-K.


