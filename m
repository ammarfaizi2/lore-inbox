Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752234AbWAFEVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbWAFEVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 23:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbWAFEVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 23:21:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:42429 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1752234AbWAFEVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 23:21:10 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: [KERNEL 2.6.15]  All files have -rw-rw-rw- permission.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060105191736.1ac95e4b.rdunlap@xenotime.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Euj6C-0008Fo-00@calista.inka.de>
Date: Fri, 06 Jan 2006 05:21:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap <rdunlap@xenotime.net> wrote:
> We (lkml) have been thru this before.
> Don't untar the tarball as root and this won't happen.

or use umask as it is suppsoed to be used with --no-same-permissions

Gruss
Bernd
