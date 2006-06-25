Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWFYQro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWFYQro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 12:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWFYQro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 12:47:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63503 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751171AbWFYQrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 12:47:43 -0400
Date: Sun, 25 Jun 2006 18:47:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ron Mercer <ron.mercer@qlogic.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
Subject: 2.6.17-mm2: no QLA3YYY_NAPI help text
Message-ID: <20060625164741.GB23314@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ resent with a subject adapted to vger mail filter... ]

On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm1:
>...
> +qla3xxx-NIC-driver.patch
>...
>  Net driver updates.  Includes a new driver from qlogic which almost compiles.
>...

The QLA3XXX_NAPI option lacks a help text.

Please add a help text.

TIA
Adrian

--

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

