Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263675AbRGNUC0>; Sat, 14 Jul 2001 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbRGNUCQ>; Sat, 14 Jul 2001 16:02:16 -0400
Received: from [24.93.67.52] ([24.93.67.52]:23059 "EHLO mail5.carolina.rr.com")
	by vger.kernel.org with ESMTP id <S263675AbRGNUCB>;
	Sat, 14 Jul 2001 16:02:01 -0400
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Sat, 14 Jul 2001 16:01:22 -0400
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac3
Message-ID: <20010714160122.A3670@clt88-175-140.carolina.rr.com>
In-Reply-To: <20010714183603.A5773@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010714183603.A5773@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o	Fix range checks in mga				(me)
> 	| I've no idea if I've broken the matrox driver in doing so
> 	| but right now I dont actually care. XFree need to fix it right
> o	Ditto for radeon				(me)
> o	Ditto for r128					(me)
> o	Ditto for matrox pci				(me)
> o	And generic drm_addbufs				(me)
> 
These drivers are already outdated .... In order to get DRI working
you need drivers that comes with XFree 4.1.0 (or the CVS version of
DRI tree ....). I doubt these are worth ... fixing at all.

ps.
I'll forward this email to dri-dever@ mailing list.
