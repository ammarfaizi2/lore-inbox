Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbSJBUkf>; Wed, 2 Oct 2002 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbSJBUkf>; Wed, 2 Oct 2002 16:40:35 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:59114 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262575AbSJBUkf>;
	Wed, 2 Oct 2002 16:40:35 -0400
Date: Wed, 2 Oct 2002 22:45:59 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cli()/sti() fix for drivers/net/ewrk3.c
Message-ID: <20021002224559.B18518@fafner.intra.cogenit.fr>
References: <200210022005.g92K5Gp31819@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210022005.g92K5Gp31819@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Oct 02, 2002 at 10:59:01PM -0200
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> :
[...]
> diff -u --recursive linux-2.5.38orig/drivers/net/ewrk3.c linux-2.5.38/drivers/net/ewrk3.c
> --- linux-2.5.38orig/drivers/net/ewrk3.c	Sun Sep 22 04:25:09 2002
> +++ linux-2.5.38/drivers/net/ewrk3.c	Wed Oct  2 01:29:31 2002
[...]

The remarks done for drivers/net/depca.c patch apply equally as well.

-- 
Ueimor
