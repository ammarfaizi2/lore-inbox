Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVDDX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDDX0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDDXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:24:45 -0400
Received: from main.gmane.org ([80.91.229.2]:29325 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261508AbVDDXWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:22:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@debian.org>
Subject: Re: Linux 2.6.12-rc2
Date: Mon, 04 Apr 2005 19:04:02 -0400
Message-ID: <pan.2005.04.04.23.03.58.312203@debian.org>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-194-62-26.nycap.res.rr.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
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
>   o fix pci_disable_device in 8139too
> 

The first two fixes were from Panagiotis Issaris
<takis@lumumba.luc.ac.be>; I merely forwarded them on.


