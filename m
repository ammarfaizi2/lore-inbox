Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTJLWpX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTJLWpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 18:45:22 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:25017 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261234AbTJLWpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 18:45:21 -0400
Date: Sun, 12 Oct 2003 15:45:19 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Jens Axboe <axboe@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, marcelo.tosatti@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode
Message-ID: <20031012224519.GA9043@ip68-4-255-84.oc.oc.cox.net>
References: <200310091103.h99B31ug014566@hera.kernel.org> <3F856A7E.2010607@pobox.com> <20031009140547.GD1232@suse.de> <20031009141734.GB23545@redhat.com> <20031009142632.GI1232@suse.de> <20031011114913.GA516@elf.ucw.cz> <20031011135943.GB1107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011135943.GB1107@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 03:59:43PM +0200, Jens Axboe wrote:
> Not very likely, imho. People have been using spin down with hdparm for
> years (in Linux and elsewhere), while acoustic management is a bit more
> esoteric.

I'm having trouble finding this on Google now, but I've heard rumors
over the years of old Fireball drives corrupting data if they receive
write commands too soon after spinning up (i.e., the drive doesn't
bother waiting to spin up fully first). Maybe I'm not remembering the
details correctly, but it was something about the drive trying to act on
commands before it was fully spun up and malfunctioning as a result.

-Barry K. Nathan <barryn@pobox.com>
