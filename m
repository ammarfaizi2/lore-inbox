Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVDXB3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVDXB3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 21:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVDXB3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 21:29:50 -0400
Received: from quechua.inka.de ([193.197.184.2]:28629 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262220AbVDXB3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 21:29:48 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050423174227.51360d63.pj@sgi.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DPVwN-0007pj-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 24 Apr 2005 03:29:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050423174227.51360d63.pj@sgi.com> you wrote:
> If something is likely to happen less than once in a billion years,
> then for all practical purposes, it won't happen.

Of course there are colliding files already available and easyly
generate-able. So a malicous attack is already possible. 

Which is especially nasty because one can proof GIT obeject file system is
broken. However I dont think it is a problem for Linux Source Control
purpose, ever.

However using a combined hash might be a good idea, here. So you silence the
critics since they have no eploit samples handy. :) Or at least go with FIPS
180-2.

Greetings
Bernd
