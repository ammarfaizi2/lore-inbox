Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUHAO54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUHAO54 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHAO5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:57:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34521 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266002AbUHAO5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:57:45 -0400
Date: Sun, 1 Aug 2004 16:57:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>, Oliver Neukum <oliver@neukum.name>,
       Ali Akcaagac <aliakc@web.de>, Jamie Lenehan <lenehan@twibble.org>
Subject: Re: [PATCH] fix gcc 3.4 inlining errors in drivers/scsi/dc395x.c
Message-ID: <20040801145739.GT2746@fs.tum.de>
References: <Pine.LNX.4.60.0408011355080.2535@dragon.hygekrogen.localhost> <20040801141541.GO2746@fs.tum.de> <Pine.LNX.4.60.0408011642060.2535@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0408011642060.2535@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 04:45:38PM +0200, Jesper Juhl wrote:
>
> Ohh, OK, I did a search in my lkml mailbox before sending off the patch, 
> guess I missed it.
>...

No, I accidentially sent this patch only to linux-scsi.

> /Jesper

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

