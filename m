Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVLPWVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVLPWVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVLPWVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:21:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55814 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932530AbVLPWVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:21:54 -0500
Date: Fri, 16 Dec 2005 23:21:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: linux 2.6.14.4 sparc compile problem
Message-ID: <20051216222154.GK23349@stusta.de>
References: <Pine.LNX.4.64.0512160832350.995@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512160832350.995@innerfire.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 08:33:48AM -0500, Gerhard Mack wrote:
> Hello, 
> 
> I tried to compile kernel 2.6.14.4 on my sparc and I got this:
> 
> drivers/built-in.o(.init.text+0x1184): In function `rtc_init':
> : undefined reference to `ebus_chain'
> drivers/built-in.o(.init.text+0x1188): In function `rtc_init':
> : undefined reference to `ebus_chain'
> drivers/built-in.o(.init.text+0x1190): In function `rtc_init':
> : undefined reference to `isa_chain'
> drivers/built-in.o(.init.text+0x11d4): In function `rtc_init':
> : undefined reference to `isa_chain'
> drivers/built-in.o(.init.text+0x11d8): In function `rtc_init':
> : undefined reference to `isa_chain'
> make: *** [.tmp_vmlinux1] Error 1

Please send your .config .

> Gerhard Mack

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

