Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVEIOUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVEIOUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVEIOTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:19:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57106 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261382AbVEIOTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:19:14 -0400
Date: Mon, 9 May 2005 15:19:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document the fact that linux-arm-kernel is subscribers-only.
Message-ID: <20050509151907.A18073@flint.arm.linux.org.uk>
Mail-Followup-To: Alexey Dobriyan <adobriyan@mail.ru>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200505091821.43648.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200505091821.43648.adobriyan@mail.ru>; from adobriyan@mail.ru on Mon, May 09, 2005 at 06:21:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 06:21:43PM +0000, Alexey Dobriyan wrote:
> "Non-members are not allowed to post messages to this list. Blame the
> original poster for cross-posting to subscriber-only mailing lists. "
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Acked-by: Russell King <rmk@arm.linux.org.uk>

> 
> --- a/MAINTAINERS	2005-05-07 23:09:07.000000000 +0000
> +++ b/MAINTAINERS	2005-05-09 18:01:13.000000000 +0000
> @@ -293,7 +293,7 @@ S:	Maintained
>  ARM/PT DIGITAL BOARD PORT
>  P:	Stefan Eletzhofer
>  M:	stefan.eletzhofer@eletztrick.de
> -L:	linux-arm-kernel@lists.arm.linux.org.uk
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  W:	http://www.arm.linux.org.uk/
>  S:	Maintained
>  
> @@ -306,21 +306,21 @@ S:	Maintained
>  ARM/STRONGARM110 PORT
>  P:	Russell King
>  M:	rmk@arm.linux.org.uk
> -L:	linux-arm-kernel@lists.arm.linux.org.uk
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  W:	http://www.arm.linux.org.uk/
>  S:	Maintained
>  
>  ARM/S3C2410 ARM ARCHITECTURE
>  P:	Ben Dooks
>  M:	ben-s3c2410@fluff.org
> -L:	linux-arm-kernel@lists.arm.linux.org.uk
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
>  
>  ARM/S3C2440 ARM ARCHITECTURE
>  P:	Ben Dooks
>  M:	ben-s3c2440@fluff.org
> -L:	linux-arm-kernel@lists.arm.linux.org.uk
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
>  
> @@ -1837,7 +1837,7 @@ S:	Maintained
>  PXA2xx SUPPORT
>  P:	Nicolas Pitre
>  M:	nico@cam.org
> -L:	linux-arm-kernel@lists.arm.linux.org.uk
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  S:	Maintained
>  
>  QLOGIC QLA2XXX FC-SCSI DRIVER
> @@ -2139,7 +2139,7 @@ SHARP LH SUPPORT (LH7952X & LH7A40X)
>  P:	Marc Singer
>  M:	elf@buici.com
>  W:	http://projects.buici.com/arm
> -L:	linux-arm-kernel@lists.arm.linux.org.uk
> +L:	linux-arm-kernel@lists.arm.linux.org.uk	(subscribers-only)
>  S:	Maintained
>  
>  SPARC (sparc32):

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
