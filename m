Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVHIUVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVHIUVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVHIUVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:21:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34058 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964936AbVHIUVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:21:51 -0400
Date: Tue, 9 Aug 2005 22:21:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Klasyk <klasyk99@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: my kernel sometimes did a crash, but no panic
Message-ID: <20050809202147.GH4006@stusta.de>
References: <200508091804050500.042A58AE@friko2.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508091804050500.042A58AE@friko2.onet.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 06:04:05PM +0200, Klasyk wrote:

> my kernel sometimes did a crash, but no panic
> Keyboard hunged up :(
> Network were working and I can log in. Without the keybord - it
> generally worked.
> 
> In logs:
> for example:
>...
> Aug  6 15:30:02 o kernel: Modules linked in: ip_nat_irc
>...
>  btcx-risc tveeprom i2c-core nvidia agpgart usblp ehci-hcd uhci-hcd
>...
> Aug  6 15:30:02 o kernel: EIP:    0060:[<c026b0d9>]    Tainted: P
>...
> it is not apic problem, i disabled it, and it didn't help
> Linux o 2.6.11-12mdkcustom #2 Sat Aug 6 11:02:20 CEST 2005 i686 AMD
> Duron(TM) unknown GNU/Linux
>...

Does this problem still occur with:
- a vanilla 2.6.13-rc6 ftp.kernel.org kernel and
- without loading any external modules since booting?

If it doesn't it's completely off-topic here and you should ask either 
Mandrake or Nvidia for support.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

