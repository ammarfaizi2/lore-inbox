Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWDDPKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWDDPKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWDDPKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:10:42 -0400
Received: from xenotime.net ([66.160.160.81]:26585 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750701AbWDDPKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:10:42 -0400
Date: Tue, 4 Apr 2006 08:12:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: jengelh@linux01.gwdg.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: menuconfig search (Re: [rfc] fix Kconfig, hotplug_cpu is needed
 for swsusp)
Message-Id: <20060404081242.526ac0ac.rdunlap@xenotime.net>
In-Reply-To: <20060404060156.GE16658@mipter.zuzino.mipt.ru>
References: <20060329220808.GA1716@elf.ucw.cz>
	<200603300936.22757.ncunningham@cyclades.com>
	<20060329154748.A12897@unix-os.sc.intel.com>
	<200603300953.32298.ncunningham@cyclades.com>
	<Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr>
	<20060403221537.79bb3af9.rdunlap@xenotime.net>
	<20060404060156.GE16658@mipter.zuzino.mipt.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006 10:01:56 +0400 Alexey Dobriyan wrote:

> On Mon, Apr 03, 2006 at 10:15:37PM -0700, Randy.Dunlap wrote:
> > Re verbosity:  do you know that menuconfig search (/) takes regular
> > expressions?  That could help someone limit the amount of output
> > from it.
> 
> (Inability to jump from search screen directly to just found config option to
> set/unset it AND verbose output) is broken. Verbose output solely is probably
> not a big deal.

I don't recall seeing that ability advertised.  Yes, it would be great to
have it, but I wouldn't call it broken.

---
~Randy
