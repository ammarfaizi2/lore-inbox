Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVDDXOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVDDXOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVDDXMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:12:44 -0400
Received: from cpe-24-194-62-26.nycap.res.rr.com ([24.194.62.26]:58380 "EHLO
	spiral.voxel.net") by vger.kernel.org with ESMTP id S261478AbVDDXHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:07:52 -0400
From: Andres Salomon <dilinger@debian.org>
Subject: Re: Linux 2.6.12-rc2
Date: Mon, 04 Apr 2005 19:07:48 -0400
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.04.04.23.07.47.184568@debian.org>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Apr 2005 14:32:52 -0700, Linus Torvalds wrote:

> 
> 
> The diffstat output tells the story: this is a lot of very small changes,
> ie tons of small cleanups and bug fixes. With a few new drivers thrown in
> for good measure.
> 
> This is also the point where I ask people to calm down, and not send me
> anything but clear bug-fixes etc. We're definitely well into -rc land. So 
> keep it quiet out there,
> 
> 		Linus
> 
> ----
> Summary of changes from v2.6.12-rc1 to v2.6.12-rc2
> ==================================================
> 
[...]
> Andres Salomon:
>   o Possible AMD8111e free irq issue
>   o Possible VIA-Rhine free irq issue

These first two fixes were from Panagiotis Issaris
<takis@lumumba.luc.ac.be>; I merely forwarded them to gregkh & co.


>   o fix pci_disable_device in 8139too

