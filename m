Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266739AbUF3PnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266739AbUF3PnP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUF3PhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:37:12 -0400
Received: from penguin.linuxhardware.org ([63.173.68.170]:19381 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id S266731AbUF3PgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:36:16 -0400
Date: Wed, 30 Jun 2004 11:38:47 -0400 (EDT)
From: augustus@penguin.linuxhardware.org
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] K8T800Pro AGP Support
In-Reply-To: <20040630153134.GD12311@redhat.com>
Message-ID: <Pine.LNX.4.58.0406301137410.7801@penguin.linuxhardware.org>
References: <Pine.LNX.4.58.0406292326480.24803@penguin.linuxhardware.org>
 <20040630153134.GD12311@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  I noticed that the model numbers are prefered but I ran into the 
same road block you did.  If I find out what it is, I'll let you know.

Kris Kersey (Augustus)
LinuxHardware.org Site Manager
augustus@linuxhardware.org
Gentoo Linux AMD64 Developer
augustus@gentoo.org

On Wed, 30 Jun 2004, Dave Jones wrote:

> On Tue, Jun 29, 2004 at 11:38:54PM -0400, augustus@penguin.linuxhardware.org wrote:
>  > Patch to add support for the K8T800Pro chip in the AGPGART driver for 
>  > amd64-agp.
>  > 
>  > Signed-off-by: Kris Kersey <augustus@linuxhardware.org>
> 
> Applied, thanks.
> 
>  > +#define PCI_DEVICE_ID_VIA_K8T800PRO_0  0x0282
>  >  #define PCI_DEVICE_ID_VIA_8363_0       0x0305 
>  >  #define PCI_DEVICE_ID_VIA_8371_0       0x0391
>  >  #define PCI_DEVICE_ID_VIA_8501_0       0x0501
> 
> Although normally, it's preferred to use the chip number instead
> of its marketing name. A quick google didn't actually turn up
> its number though, so for the time being, I'll leave it like this.
> 
> 		Dave
> 
