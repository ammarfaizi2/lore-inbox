Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268524AbUIPSDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268524AbUIPSDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268590AbUIPRlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:41:13 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:39952 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S268410AbUIPRhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:37:34 -0400
Date: Thu, 16 Sep 2004 19:37:10 +0200
From: Jedi/Sector One <j@pureftpd.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040916173732.GA31672@c9x.org>
References: <20040916024020.0c88586d.akpm@osdl.org> <200409161345.56131.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409161345.56131.norberto+linux-kernel@bensa.ath.cx>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 01:45:55PM -0300, Norberto Bensa wrote:
> Andrew Morton wrote:
> > +tune-vmalloc-size.patch
> 
> This one of course breaks nvidia's binary driver; so nvidia users should do a 
> "patch -Rp1" to revert it.

http://00f.net/blogs/index.php/2004/09/16/nvidia_kernel_module_and_linux_2_6_9_rc2
