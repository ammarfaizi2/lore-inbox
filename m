Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUACRnx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUACRnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:43:53 -0500
Received: from [193.138.115.2] ([193.138.115.2]:29198 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263625AbUACRnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:43:52 -0500
Date: Sat, 3 Jan 2004 18:40:59 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: Petri Koistinen <petri.koistinen@iki.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch against 2.6.1-rc1-mm1] replace check_region with
 request_region in isp16.c
In-Reply-To: <Pine.LNX.4.58.0401031928380.1792@dsl-hkigw4g29.dial.inet.fi>
Message-ID: <Pine.LNX.4.56.0401031839320.4664@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401031750330.4664@jju_lnx.backbone.dif.dk>
 <Pine.LNX.4.58.0401031928380.1792@dsl-hkigw4g29.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jan 2004, Petri Koistinen wrote:

> Hi!
>
> On Sat, 3 Jan 2004, Jesper Juhl wrote:
>
> > drivers/cdrom/isp16.c
> > drivers/cdrom/isp16.c: In function `isp16_init':
> > drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
>
> > I would appreciate it is someone could take a quick look at the patch
>
> There was recent discussion about this, see:
>
> http://tinyurl.com/38hum and http://tinyurl.com/2wexw
>
Thank you for pointing that out. Seems like I'm duplicating effort here.

/Jesper

