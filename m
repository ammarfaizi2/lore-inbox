Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbULEWcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbULEWcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 17:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbULEWcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 17:32:04 -0500
Received: from lilah.hetzel.org ([199.250.128.2]:24220 "EHLO lilah.hetzel.org")
	by vger.kernel.org with ESMTP id S261411AbULEWcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 17:32:01 -0500
Date: Sun, 5 Dec 2004 18:55:20 -0500
From: Dorn Hetzel <kernel@dorn.hetzel.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       dorn@hetzel.org
Subject: Re: r8169.c
Message-ID: <20041205235519.GA21885@lilah.hetzel.org>
References: <20041119162920.GA26836@lilah.hetzel.org> <20041119201203.GA13522@electric-eye.fr.zoreil.com> <20041120003754.GA32133@lilah.hetzel.org> <20041120002946.GA18059@electric-eye.fr.zoreil.com> <20041122181307.GA3625@lilah.hetzel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122181307.GA3625@lilah.hetzel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 01:13:07PM -0500, Dorn Hetzel wrote:
> On Sat, Nov 20, 2004 at 01:29:46AM +0100, Francois Romieu wrote:
> 
> > Once you have applied one of the patch above, the patch below will improve
> > your "transmit timed out" (please apply in order and enable NAPI):
> > http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-250.patch
> > http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-255.patch
> > 
> > If things perform better you may want to use bigger frames and apply as
> > well r8169-260.patch and r8169-265.patch.
> > http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-260.patch
> > http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.10-rc2-mm1/r8169-265.patch
> >

I was wondering if the above 4 patches have made it into one of the
rc? releases, or at least a rc?-mm?  ?

Regards,

-Dorn

