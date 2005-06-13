Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVFMMKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVFMMKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFMMJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:09:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60426 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261524AbVFMMIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:08:37 -0400
Date: Mon, 13 Jun 2005 14:08:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Rommer <rommer@active.by>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udp.c
Message-ID: <20050613120832.GW3770@stusta.de>
References: <42AD74A3.1050006@active.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AD74A3.1050006@active.by>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 02:57:23PM +0300, Rommer wrote:

> Hello,

Hi Roman,

> Where used strange function udp_v4_hash?
> linux-2.6.11.11, net/ipv4/udp.c:204
>...

do a simple

  grep -r udp_v4_hash *

in the main directory of the kernel sources and you'll find it.

> Best regards, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

