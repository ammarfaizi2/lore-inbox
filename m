Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUGNTI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUGNTI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUGNTIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:08:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44279 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265360AbUGNTIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:08:21 -0400
Date: Wed, 14 Jul 2004 21:08:14 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch] 2.6.8-rc1-mm1: USB w9968cf compile error
Message-ID: <20040714190814.GK7308@fs.tum.de>
References: <20040713182559.7534e46d.akpm@osdl.org> <20040714184953.GI7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714184953.GI7308@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 08:49:53PM +0200, Adrian Bunk wrote:
>...
> This patch moves w9968cf_valid_depth above it's first user (it also uses 

s/uses/moves/

> two other functions to keep the ordering of functions a bit more 
> consistent).
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

