Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270444AbTGMX3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 19:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270445AbTGMX3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 19:29:25 -0400
Received: from [66.212.224.118] ([66.212.224.118]:59152 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270444AbTGMX3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 19:29:24 -0400
Date: Sun, 13 Jul 2003 19:32:50 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Max Valdez <maxvalde@fis.unam.mx>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: no sound on 2.5.75-mm1 (emu10k1 loaded)
In-Reply-To: <1058115661.6491.6.camel@garaged.homeip.net>
Message-ID: <Pine.LNX.4.53.0307131931160.29044@montezuma.mastecende.com>
References: <1058115661.6491.6.camel@garaged.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Max Valdez wrote:

> Hi all
> 
> Im very plessed to see my first 2.5 kernel running almos completly !!,
> this time I dont have sound system running, I might be missing something
> fool, but I just can't find it, here is my config attached, a dmesg and
> lsmod. There is no /dev/dsp device, no /dev/sound either.

Seems like a devfs thing, try removing it.

