Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUDXSXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUDXSXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 14:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUDXSXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 14:23:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47846 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261673AbUDXSXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 14:23:54 -0400
Date: Sat, 24 Apr 2004 20:23:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_ATALK cannot be compiled as a module (2.4.24)
Message-ID: <20040424182347.GF146@fs.tum.de>
References: <200403281401.18489.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403281401.18489.kiza@gmx.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 02:01:11PM +0200, Oliver Feiler wrote:

> Hi,

Hi Oliver,

> when selecting CONFIG_ATALK as a module the symbols register_snap_client and 
> unregister_snap_client will be unresolved. As I understand it they are in 
> net/802/psnap.c which does not get compiled when Appletalk is selected as a 
> module. Compiling into the kernel works fine.
>...

thanks for this report and sorry for the late answer.

I wasn't able to reproduce your problem.

Please send your .config.

> 	Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

