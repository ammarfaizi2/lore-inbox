Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291246AbSAaTYK>; Thu, 31 Jan 2002 14:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSAaTYA>; Thu, 31 Jan 2002 14:24:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9861 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291246AbSAaTX6>;
	Thu, 31 Jan 2002 14:23:58 -0500
Date: Thu, 31 Jan 2002 14:23:56 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: tulip woes
Message-ID: <20020131142356.B1752@havoc.gtf.org>
In-Reply-To: <20020131004733.GA25163@mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131004733.GA25163@mp3revolution.net>; from dilinger@mp3revolution.net on Wed, Jan 30, 2002 at 07:47:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 07:47:33PM -0500, Andres Salomon wrote:
> Jan 30 07:43:47 pinky kernel: eth0: Lite-On PNIC-II rev 37 at
> 0xe0836000, 00:A0:CC:33:0D:FA, IRQ 11.
> Jan 30 07:43:47 pinky kernel: eth0: Autonegotiation failed, using
> 10baseT, link
> beat status 10cc.
> Jan 30 07:44:10 pinky kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jan 30 07:44:10 pinky kernel: eth0: PNIC2 transmit timed out, status
> e4260000, CSR6/7 e0402002 / effffbff CSR12 000000c8, resetting...
> Jan 30 07:44:18 pinky kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jan 30 07:44:18 pinky kernel: eth0: PNIC2 transmit timed out, status
> e4260000, CSR6/7 e0402002 / effffbff CSR12 000000c8, resetting...

Kevin Hendricks sent me a patch for this, that I need to merge.

I'll dig it out after I return from LinuxWorld and post it here.
Additional testers such as yourself are definitely welcome.

	Jeff


