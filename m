Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVCKDME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVCKDME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVCKDMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:12:03 -0500
Received: from waste.org ([216.27.176.166]:32226 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261289AbVCKDLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:11:50 -0500
Date: Thu, 10 Mar 2005 19:11:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050311031137.GC3163@waste.org>
References: <20050310075049.GA30243@suse.de> <9e4733910503100658ff440e3@mail.gmail.com> <20050310153151.GY2578@suse.de> <9e473391050310074556aad6b0@mail.gmail.com> <20050310154830.GB2578@suse.de> <9e47339105031007595b1e0cc3@mail.gmail.com> <20050310160155.GC2578@suse.de> <9e4733910503100818df5fb2@mail.gmail.com> <20050310162918.GD2578@suse.de> <9e47339105031010527aa0e3af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105031010527aa0e3af@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 01:52:59PM -0500, Jon Smirl wrote:
> Here's a big clue, if I build ata_piix in I can boot. If it is a
> module I can't. The console output definitely shows that the module is
> being loaded.

Can you post your config?

-- 
Mathematics is the supreme nostalgia of our time.
