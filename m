Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUGFXeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUGFXeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUGFXeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:34:16 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:54590 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264704AbUGFXeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:34:14 -0400
Subject: Re: compiling 2.6.7
From: Redeeman <lkml@metanurb.dk>
To: Kefalas Apostolos <akef@freemail.gr>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200407062123.09586.akef@freemail.gr>
References: <200407062123.09586.akef@freemail.gr>
Content-Type: text/plain
Date: Wed, 07 Jul 2004 01:34:13 +0200
Message-Id: <1089156853.15544.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 21:23 +0300, Kefalas Apostolos wrote:
> I am compiling kernel 2.6.5 and i get the following errors:
what kernel are you really compiling? subject says 2.6.7

> drivers/pcmcia/i82365.c: In function `is_alive':
> drivers/pcmcia/i82365.c:672: warning: `check_region' is deprecated (declared 
> at include/linux/ioport.h:121)
> drivers/pcmcia/i82365.c: In function `isa_probe':
> drivers/pcmcia/i82365.c:806: warning: `check_region' is deprecated (declared 
> at include/linux/ioport.h:121)
> drivers/pcmcia/i82365.c: In function `i365_set_io_map':
> drivers/pcmcia/i82365.c:1134: warning: comparison is always false due to 
> limited range of data type
> drivers/pcmcia/i82365.c:1134: warning: comparison is always false due to 
> limited range of data type
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

