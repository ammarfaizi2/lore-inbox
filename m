Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275014AbTHRUkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHRUkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:40:47 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:40197 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S275014AbTHRUkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:40:43 -0400
Date: Mon, 18 Aug 2003 22:40:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030818204040.GA4961@mars.ravnborg.org>
Mail-Followup-To: Ihar 'Philips' Filipau <filia@softhome.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <lRjg.6o4.15@gated-at.bofh.it> <lWLS.39x.5@gated-at.bofh.it> <lWLZ.39x.29@gated-at.bofh.it> <3F4120DD.3030108@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4120DD.3030108@softhome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:54:21PM +0200, Ihar 'Philips' Filipau wrote:
> 
>    There is no need to be a prophet to predict linux/abi being 99% 
> symlinks right into include/{asm,linux}.
Symlinks will not be included in the vanilla kernel source.
But if several files just had to be moved that would be a good start.

With potential wrappers in include/linux obviously.

	Sam
