Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSEMPJs>; Mon, 13 May 2002 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313882AbSEMPJr>; Mon, 13 May 2002 11:09:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18306 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313589AbSEMPJq>; Mon, 13 May 2002 11:09:46 -0400
Date: Mon, 13 May 2002 11:08:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: William Thompson <wt@electro-mechanical.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sg in 2.4.18
In-Reply-To: <20020513101050.A3879@coredump.electro-mechanical.com>
Message-ID: <Pine.LNX.3.95.1020513110702.26384A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, William Thompson wrote:

> Is it possible to open sg more than once for multiple devices?
> 
> IE, cdrecord 2 cds at once.
> -

Yes, but not the same device. Each CD should have its own device.
FYI, it works very well with SCSI devices, but I haven't tried
it with IDE.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

