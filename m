Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265163AbRFUTvl>; Thu, 21 Jun 2001 15:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265162AbRFUTvc>; Thu, 21 Jun 2001 15:51:32 -0400
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:24224 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S265163AbRFUTvQ>; Thu, 21 Jun 2001 15:51:16 -0400
Date: Thu, 21 Jun 2001 15:51:09 -0400
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac17
Message-ID: <20010621155109.A15532@zero>
In-Reply-To: <20010621173855.A6444@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621173855.A6444@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Thu, Jun 21, 2001 at 05:38:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anyone working on a bootflag.c for alpha?

init/main.o: In function `init':
main.c(.text+0x148): undefined reference to `linux_booted_ok'
main.c(.text+0x14c): undefined reference to `linux_booted_ok'
make: *** [vmlinux] Error 1

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
