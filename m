Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270615AbTGNOLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270617AbTGNOI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:08:26 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:30166 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270615AbTGNOHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:07:14 -0400
Date: Mon, 14 Jul 2003 16:21:52 +0200
To: Dave Jones <davej@codemonkey.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714142152.GC20708@h55p111.delphi.afb.lu.se>
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se> <20030714135948.GA27930@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714135948.GA27930@suse.de>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19c4DA-0007Kw-00*RjlYV1IMYyM*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 02:59:48PM +0100, Dave Jones wrote:
> First you should read (and preferably act upon) the comments
> sent the last time you posted this.
> 
> Notably the gcc 'workaround' and the HZ ifdef maze.

Ooops, wrong patch. I have a labyrinth of bitkeeper-trees here, all looking
almost the same.

The real patch contains cleaned up HZ-ifdefs.

Regarding the gcc "workaround" I said:

"I don't really know how to make clear it's not a gcc problem. But if it was,
 why doesn't it crash on pc and 1.0 xboxen? And why does it crash on kernels
 compiled with 2.95, with or without optimization? I really wish I had the
 explaination to this problem."
 
Or as Christoph answered: "Oh well, stupid crappy hardware..."

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
