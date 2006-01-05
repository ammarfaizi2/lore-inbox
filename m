Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWAEHaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWAEHaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWAEHaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:30:19 -0500
Received: from quechua.inka.de ([193.197.184.2]:36267 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751916AbWAEHaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:30:18 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060104221023.10249eb3.rdunlap@xenotime.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EuPZg-0008Kw-00@calista.inka.de>
Date: Thu, 05 Jan 2006 08:30:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap <rdunlap@xenotime.net> wrote:
> This one delays each printk() during boot by a variable time
> (from kernel command line), while system_state == SYSTEM_BOOTING.

This sounds a bit like a aprils fool joke, what it is meant to do? You can
read the messages in the bootlog and use the scrollback keys, no?

Gruss
Bernd
