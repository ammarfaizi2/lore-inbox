Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTIHS2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263465AbTIHS2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:28:00 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:17024 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S263459AbTIHS16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:27:58 -0400
Subject: Re: New ATI FireGL driver supports 2.6 kernel
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org, dri-users@lists.sourceforge.net
In-Reply-To: <1063045080.21991.13.camel@chevrolet.hybel>
References: <1063044345.1895.10.camel@hades>
	 <1063045080.21991.13.camel@chevrolet.hybel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063045671.2637.3.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 21:27:51 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-08 at 21:18, Stian Jordet wrote:
> > Just in case anyone is interested, ATI has released version 3.2.5 of
> > their FireGL driver for XFree86. The driver supports all their high end
> > graphics cards. This is the first version that has DRM support for the
> > 2.6 series of kernels.
> 
> Well.. Not really :)
> 
> chevrolet:/lib/modules/fglrx/build_mod/2.6.x# make
...
> make: *** [kmod_build] Error 2
> chevrolet:/lib/modules/fglrx/build_mod/2.6.x#

Hmm. I did manage to build it, although I got my version from here
instead of ATI's site:

http://www.schneider-digital.de/html/download_ati.html

Maybe there's a difference. Using the new glue code, I also managed to
build a kernel module for the older 2.9.13 driver as 3.2.5 seems a bit
flakey with my radeon 9700 pro.

Cheers,

	MikaL

