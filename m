Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276695AbRJVTxj>; Mon, 22 Oct 2001 15:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278852AbRJVTx3>; Mon, 22 Oct 2001 15:53:29 -0400
Received: from ns.ithnet.com ([217.64.64.10]:53260 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S278655AbRJVTxQ>;
	Mon, 22 Oct 2001 15:53:16 -0400
Date: Mon, 22 Oct 2001 21:53:35 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: jarausch@belgacom.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module, or not?
Message-Id: <20011022215335.18a31d9d.skraw@ithnet.com>
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be>
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 20:45:22 +0200 (CEST) jarausch@belgacom.net wrote:

> [...]
> Running pre6 I get
> (==) NVIDIA(0): Write-combining range (0xf0000000,0x2000000)
> (EE) NVIDIA(0): Failed to allocate LUT context DMA
> (EE) NVIDIA(0):  *** Aborting ***

Probably you should do additional checks. I run a GeForce II MX here with
exactly this driver and pre6 - and have no problem at all. I tried both driver
version 1251 and 1541, and both work.

Of course I do not back the manufacturers' religion "we don't wanna show people
how we managed to make a kernel driver 800kB of size". Only I believe this is
no real loss, as nobody wants to follow this god anyway.

:-)

Regards,
Stephan


