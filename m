Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUACRct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUACRcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:32:48 -0500
Received: from dsl-hkigw4g29.dial.inet.fi ([80.222.54.41]:32642 "EHLO
	dsl-hkigw4g29.dial.inet.fi") by vger.kernel.org with ESMTP
	id S263600AbUACRcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:32:47 -0500
Date: Sat, 3 Jan 2004 19:32:46 +0200 (EET)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4g29.dial.inet.fi
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, H.T.M.v.d.Maarel@marin.nl
Subject: Re: [patch against 2.6.1-rc1-mm1] replace check_region with
 request_region in isp16.c
In-Reply-To: <Pine.LNX.4.56.0401031750330.4664@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.58.0401031928380.1792@dsl-hkigw4g29.dial.inet.fi>
References: <Pine.LNX.4.56.0401031750330.4664@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, 3 Jan 2004, Jesper Juhl wrote:

> drivers/cdrom/isp16.c
> drivers/cdrom/isp16.c: In function `isp16_init':
> drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)

> I would appreciate it is someone could take a quick look at the patch

There was recent discussion about this, see:

http://tinyurl.com/38hum and http://tinyurl.com/2wexw

Petri
