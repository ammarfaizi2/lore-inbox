Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292223AbSBTT25>; Wed, 20 Feb 2002 14:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSBTT2v>; Wed, 20 Feb 2002 14:28:51 -0500
Received: from toole.uol.com.br ([200.231.206.186]:63142 "EHLO
	toole.uol.com.br") by vger.kernel.org with ESMTP id <S292223AbSBTT2B>;
	Wed, 20 Feb 2002 14:28:01 -0500
Date: Wed, 20 Feb 2002 16:27:26 -0300 (BRT)
From: Cesar Suga <sartre@linuxbr.com>
To: Thomas Winischhofer <tw@webit.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A simple patch for SIS (documentation and kbuild)
In-Reply-To: <3C73EBD2.2116ECA8@webit.com>
Message-ID: <Pine.LNX.4.40.0202201625000.2588-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Thomas Winischhofer wrote:

> +SiS 300/540/630
> +CONFIG_DRM_SIS
> +  Choose this option if you have a SIS 300, 540 or 630 graphics card.
> +  If M is selected, the module will be called sis.o.  AGP support is
> +  required for this driver to work.

> Before posting patches you'd better inform yourself.

> AGP is *not* required.

	Ah, sorry. I didn't notice __MUST_HAVE_AGP to be zero. I'll take
care.

	Regards,
	Cesar Suga <sartre@linuxbr.com>


