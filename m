Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424254AbWLBR3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424254AbWLBR3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424262AbWLBR3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:29:31 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:6418
	"HELO linuxace.com") by vger.kernel.org with SMTP id S1424254AbWLBR3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:29:31 -0500
Date: Sat, 2 Dec 2006 09:29:30 -0800
From: Phil Oester <kernel@linuxace.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: skb_over_panic, followed by a BUG at net/core/skbuff.c:93
Message-ID: <20061202172930.GA27179@linuxace.com>
References: <45718AE9.8060202@dbservice.com> <eks6q6$v3t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eks6q6$v3t$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 04:40:54PM +0100, Helge Deller wrote:
> > The bug happens when gentoo wants to bring up eth0 (starting the lo
> > device works fine), even a simple 'ifconfig eth0 192.168.0.11' will
> > crash the kernel.

> I just faced the same problem, but on a HPPA (PARISC) box with 32bit kernel.
> Just reported at the parisc-linux kernel mailing list as well:
> http://lists.parisc-linux.org/pipermail/parisc-linux/2006-December/030810.html

Please read the mailing list archives...this has been covered
a number of times in the past few days.

Phil
