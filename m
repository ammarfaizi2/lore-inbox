Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbUKNU5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUKNU5A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbUKNUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:54:16 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:23506 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261378AbUKNUyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:54:02 -0500
Date: Sun, 14 Nov 2004 12:53:39 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - UML - add initramfs to Kconfig
Message-ID: <20041114205339.GA10870@taniwha.stupidest.org>
References: <200411142304.iAEN4MbV013366@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411142304.iAEN4MbV013366@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 06:04:22PM -0500, Jeff Dike wrote:

> Trivial patch (copy and yank) so UML builds don't generate a warning
> from linux/usr/Makefile:gen_cmd_list when CONFIG_INITRAMFS_SOURCE
> isn't defined (maybe the Makefile shouldn't require
> CONFIG_INITRAMFS_SOURCE to be set?).

This is already in the BK tree... for about 3 weeks now!  What tree
are you working from?
