Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRJANuK>; Mon, 1 Oct 2001 09:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275086AbRJANuA>; Mon, 1 Oct 2001 09:50:00 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:2309 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S275082AbRJANtu>;
	Mon, 1 Oct 2001 09:49:50 -0400
To: julien23@alcove.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
In-Reply-To: <20011001120432.A5531@come.alcove-fr>
In-Reply-To: <20010930174627.52817587@thanatos.toad.net> <20011001120432.A5531@come.alcove-fr>
Reply-To: stephane.list@fr.alcove.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Message-Id: <E15o3SZ-0005mL-00@wiliam.alcove-fr>
From: St?phane List <stephane@alcove.fr>
Date: Mon, 01 Oct 2001 15:50:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le driver de stelian est tombé en marche ;-)


In alcove.lists.linux.kernel, you wrote:
> On Sun, Sep 30, 2001 at 01:46:26PM -0400, Thomas Hood wrote:
> 
> > Here's the patch to the PnP BIOS driver for Vaio laptops again,
> > this time against 2.4.9-ac18.  It's unchanged, but as per the
> > "SubmittingPatches" file, I append rather than attach it.   
> > // Thomas
> 
> Ok, here I am again, sorry for not being able to react on 
> your patches this weekend...
> 
> I tested your latest patches with a 2.4.9-ac18 kernels, and,
> surprise, the kernel now boots correctly, _without_ any
> pnpbios* boot option.
> 
> Since the DMI / PNP order was not modified as of ac18, I
> suppose the patches change something else which makes it
> work...
> 
> Stelian.
> -- 
> Stelian Pop <stelian.pop@fr.alcove.com>
> |---------------- Free Software Engineer -----------------|
> | Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
> |------------- Alcôve, liberating software ---------------|
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
