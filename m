Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272647AbTHKOsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272587AbTHKOrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:47:47 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:64966
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S272605AbTHKOrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:47:10 -0400
Date: Mon, 11 Aug 2003 10:47:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: davej@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] c99 initialisers for random.c
Message-ID: <20030811144709.GA32180@gtf.org>
References: <E19mCuO-0003da-00@tetrachloride>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19mCuO-0003da-00@tetrachloride>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 02:40:24PM +0100, davej@redhat.com wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/random.c linux-2.5/drivers/char/random.c
> --- bk-linus/drivers/char/random.c	2003-08-04 01:00:22.000000000 +0100
> +++ linux-2.5/drivers/char/random.c	2003-08-06 18:59:31.000000000 +0100

Wow.  That is so much more clean (to my eyes).

	Jeff



