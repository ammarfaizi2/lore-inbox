Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273054AbRI0OFm>; Thu, 27 Sep 2001 10:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273058AbRI0OFc>; Thu, 27 Sep 2001 10:05:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S273054AbRI0OFT>; Thu, 27 Sep 2001 10:05:19 -0400
Date: Thu, 27 Sep 2001 10:05:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: dssingh@hss.hns.com
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP parameter configuraion
In-Reply-To: <65256AD4.004D0DA6.00@sandesh.hss.hns.com>
Message-ID: <Pine.LNX.3.95.1010927100404.439A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001 dssingh@hss.hns.com wrote:

> 
> 
> hi
> 
>      We want to configure tcp_rexmit_interval_min, tcp_rexmit_interval_max etc
>      parameters in the TCP/IP stack of our Linux machine.
> 

/proc/sys/net/ipv4 is the interface for many network configurable
parameters. Suggest you look there first.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


