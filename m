Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283691AbRK3QRH>; Fri, 30 Nov 2001 11:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283696AbRK3QQr>; Fri, 30 Nov 2001 11:16:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S283691AbRK3QQi>; Fri, 30 Nov 2001 11:16:38 -0500
Date: Fri, 30 Nov 2001 11:16:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jessica Blank <jessica@twu.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the problem!
In-Reply-To: <Pine.LNX.4.40.0111301002110.3351-100000@twu.net>
Message-ID: <Pine.LNX.3.95.1011130111428.536A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Jessica Blank wrote:

> Sooo... having the Windows-type person remove NetBEUI and Windows
> filesharing (SMB) would fix this if this is indeed the cause of problems?
> 

Just turn OFF NetBEUI. Enable TCP/IP and NETBIOS (only). Everybody
can "share" as usual. No negative impact upon anybody.

Cheers,

Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


