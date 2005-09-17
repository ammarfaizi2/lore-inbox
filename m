Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVIQNGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVIQNGt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 09:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVIQNGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 09:06:49 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:15492 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751104AbVIQNGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 09:06:48 -0400
Message-ID: <432C14E2.10001@gmail.com>
Date: Sat, 17 Sep 2005 15:06:42 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: simon.d.matthews@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Ethernet interface problem -- system lockup.
References: <40b4372005091616024e4dd9a3@mail.gmail.com>
In-Reply-To: <40b4372005091616024e4dd9a3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Matthews napsal(a):

>The machine became unresponsive immediately after this. It would not
>respond to either the network, or keyboard.
>
>It is running a RedHat kernel 2.4.20 or similar. 
>  
>
2.4.31 update?

>Sep 15 16:20:28 xxxx kernel: eth1: Error -- Rx packet size(8172) > mtu(1500)+14
>Sep 15 16:20:28 xxxx kernel: eth1: Error -- Rx packet size(8172) > mtu(1500)+14
>Sep 15 16:20:28 xxxx last message repeated 9 times
>Sep 15 16:20:28 xxxx kernel: eth1: Error -- Rx packet size(4391) > mtu(1500)+14
>Sep 15 16:21:19 xxxx last message repeated 8 times
>Sep 15 16:21:19 xxxx kernel: eth1: Rx ERROR!!!
>Sep 15 16:21:20 xxxx last message repeated 31 times
>Sep 15 16:21:20 xxxx kernel: !!!
>Sep 15 16:21:20 xxxx kernel: !!!
>Sep 15 16:21:20 xxxx kernel: eth1: Rx ERR!!!
>Sep 15 16:21:20 xxxx kernel: eth1: Rx ERR!!!
>Sep 15 16:21:20 xxxx kernel: eth1: Rx ERRO!!!
>Sep 15 16:21:20 xxxx kernel: eth1: Rx ERRO!!!
>Sep 15 16:21:20 xxxx kernel: eth1: Rx ERR!!!
>  
>
Is it possible to tell kernel to be more debug (and syslog)?
Which drivers? Which hardware? .config
Some more info needed.

Maybe netdev is beeter mailing list for this.

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

