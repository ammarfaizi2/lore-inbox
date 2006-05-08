Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWEHWYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWEHWYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEHWYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:24:19 -0400
Received: from quechua.inka.de ([193.197.184.2]:25580 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751326AbWEHWYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:24:18 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060508152255.GF1875@harddisk-recovery.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FdE9I-00058a-00@calista.inka.de>
Date: Tue, 09 May 2006 00:24:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> wrote:
> ... except that any kernel < 2.6 didn't account tasks waiting for disk
> IO. Load average has always been somewhat related to tasks contending
> for CPU power.

Actually all Linux kernels accounted for diskwaits and others like BSD based
not. It is a very old linux oddness.

Gruss
Bernd
