Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbTBNXDW>; Fri, 14 Feb 2003 18:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTBNXDW>; Fri, 14 Feb 2003 18:03:22 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33258 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267529AbTBNXDV>; Fri, 14 Feb 2003 18:03:21 -0500
Date: Sat, 15 Feb 2003 00:13:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Ognen Duzlevski <ognen@kc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcom 10/100/1000 network cards and linux
Message-ID: <20030214231305.GQ20159@fs.tum.de>
References: <3E4AA262.8060107@kc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4AA262.8060107@kc.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 01:37:06PM -0600, Ognen Duzlevski wrote:

> Hi, there was some discussion here in the past on the bugginess of the 
> driver for the Broadcom 5702 Gb (10/100/1000) network cadrs (shipped 
> mostly with Compaq/HP boxes as standard item). Is this still an issue or 
> have the problems been resolved? Is this network card fully supported 
> under Linux 2.4.x and 2.5.x?

It should be supported with the tg3 driver included in 2.4.20.

This driver should work OK.

> Thank you,
> Ognen

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

