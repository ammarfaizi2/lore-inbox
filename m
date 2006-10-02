Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbWJBGrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbWJBGrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWJBGrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:47:04 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22424 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932681AbWJBGrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:47:02 -0400
Date: Mon, 2 Oct 2006 08:45:18 +0200 (MEST)
Message-Id: <200610020645.k926jI3K007324@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: akpm@osdl.org, jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedule ftape removal
Cc: linux-tape@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 01:05:28 -0400, Jeff Garzik wrote:
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index 9364f47..57e72e6 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -325,3 +325,11 @@ Why:	i2c-isa is a non-sense and doesn't 
>  Who:	Jean Delvare <khali@linux-fr.org>
>  
>  ---------------------------
> +
> +What:	ftape
> +When:	2.6.20
> +Why:	Orphaned for ages.  SMP bugs long unfixed.  Few users left
> +	in the world.
> +Who:	Jeff Garzik <jeff@garzik.org>

I actually have the hardware, but with a capacity of 1.6GB
per tape and transfer speeds at a few hundred KB/s it's not
the most practical backup solution today.

Removing it is perfectly acceptable for me.

/Mikael
