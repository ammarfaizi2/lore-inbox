Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUAVWT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUAVWT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:19:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13797 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266395AbUAVWTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:19:25 -0500
Date: Thu, 22 Jan 2004 23:19:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Patrick Steiner <patricksteiner@bluewin.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Samba (setsockopt SO_BSDCOMPAT)
Message-ID: <20040122221917.GQ6441@fs.tum.de>
References: <400058DF.7010307@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400058DF.7010307@bluewin.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 08:56:15PM +0100, Patrick Steiner wrote:

> What can it mean when the kernel 2.6.1 every time when i boot this 
> messages prints:
> 
> Jan 10 20:42:48 mybag kernel: process `snmptrapd' is using obsolete 
> setsockopt SO_BSDCOMPAT
> Jan 10 20:42:48 mybag kernel: process `snmpd' is using obsolete 
> setsockopt SO_BSDCOMPAT

You have to upgrade your snmpd to get rid of this message.

> and another courios thing is this message when i start a program (like 
> /usr/bin/top):
> 
> Unknow HZ Value (90) Assume 100

You need a more recent procps.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

