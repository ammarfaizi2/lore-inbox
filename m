Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVGDQ4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVGDQ4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVGDQ4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:56:33 -0400
Received: from fsmlabs.com ([168.103.115.128]:40895 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261416AbVGDQ4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:56:30 -0400
Date: Mon, 4 Jul 2005 11:01:01 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Martin Mokrejs <mmokrejs@ribosome.natur.cuni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Two 2.6.13-rc1 kernel crashes
In-Reply-To: <42C96047.60602@ribosome.natur.cuni.cz>
Message-ID: <Pine.LNX.4.61.0507041100110.2986@montezuma.fsmlabs.com>
References: <42C96047.60602@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Martin Mokrejs wrote:

> Hi,
>   I use on i686 architecture Gentoo linux with XFS filesystem.
> Recently it happened to me 3 time that the machine locked,
> although at least once sys-rq+b worked. Here is the log
> from remote console. I don't remeber having such problems
> with 2.6.12-rc6-git2, which was my previous testing kernel.
> The problems appear under heavy load when I compile/install
> some packages and maybe it's just a bad coincidence or not,
> when I move my usb mouse in fvwm2 environment. The machine
> locks.
> Any clues? Please Cc: me in replies.

Could you send your .config, and also test without CONFIG_4KSTACKS (if 
enabled)?

Thanks,
	Zwane

