Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbTA3WRa>; Thu, 30 Jan 2003 17:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbTA3WRa>; Thu, 30 Jan 2003 17:17:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3478 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267648AbTA3WR3>; Thu, 30 Jan 2003 17:17:29 -0500
Date: Thu, 30 Jan 2003 17:29:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Howard Shane <ozymandias@charter.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel craps out accessing Sony CDRW with ide-scsi
In-Reply-To: <3E399431.2080603@charter.net>
Message-ID: <Pine.LNX.3.95.1030130172833.7083A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2003, Howard Shane wrote:

> FYI I am running 2.4.20, and the CDRW in question is the master on the 
> bus it is attached to. I'll be happy to send more logs of the event or 
> any other info you request.  Thanks
> 

Look at yesterday's mail. Somebody posted a fix. It was a definite
"doing something out-of-order" fix.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


