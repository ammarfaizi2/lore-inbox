Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTFGPxr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 11:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFGPxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 11:53:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52179 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262525AbTFGPxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 11:53:45 -0400
Date: Sat, 7 Jun 2003 18:07:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.70-mm5: sc1200.c compile error if !CONFIG_PROC_FS
Message-ID: <20030607160714.GB3708@fs.tum.de>
References: <200306071731.28130.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306071731.28130.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 05:31:28PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Fixed now.
> --
> Bartlomiej
> 
> [ide] fix compilation of NS SC1x00 driver without procfs
>...

Yes, this fixes it.

Thanks for your quick reply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

