Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265294AbUETWt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUETWt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbUETWt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:49:57 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:5521 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265272AbUETWtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:49:53 -0400
Subject: Re: Sluggish performances with FreeBSD
From: Laurent Goujon <laurent.goujon@online.fr>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20040521003616.D2172@electric-eye.fr.zoreil.com>
References: <1085080302.7764.20.camel@caribou.no-ip.org>
	 <20040520193406.GA16184@ss1000.ms.mff.cuni.cz>
	 <1085083195.4240.4.camel@caribou.no-ip.org>
	 <20040520232957.A2172@electric-eye.fr.zoreil.com>
	 <1085091424.4238.13.camel@caribou.no-ip.org>
	 <20040521003616.D2172@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1085093395.4238.22.camel@caribou.no-ip.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7-2mdk 
Date: Fri, 21 May 2004 00:49:55 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven, 21/05/2004 à 00:36 +0200, Francois Romieu a écrit :
> Re,
> 
> Laurent Goujon <laurent.goujon@online.fr> :
> [...]
> > sis900.c: v1.08.07 11/02/2003
> > eth0: Unknown PHY transceiver found at address 1.
> 
> This one is probably for Daniele Venzano (webvenza@libero.it).
> You should check the l-k archive from 05/18/2004 and 05/19/2004
> (search for the subject: Re: [PATCH] Sis900 bug fixes 3/4).
I've checked this one before posting but in my case, I've only one PHY
transceiver according to dmesg, so this patch has probably no effect...

Laurent

> --
> Ueimor
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


