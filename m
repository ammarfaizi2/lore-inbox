Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUE3Bll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUE3Bll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 21:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUE3Bll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 21:41:41 -0400
Received: from quechua.inka.de ([193.197.184.2]:3292 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261500AbUE3Blk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 21:41:40 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 probem in 2.4.25 with 4 procs?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040530001212.GI24213@rdlg.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BUFKU-0005IN-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 30 May 2004 03:41:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040530001212.GI24213@rdlg.net> you wrote:
> "du -h" and "df -h" report a 1 Gig difference.

du and df calculate the used sizes quite differently. 10% differences  are quite common.

I dont think this is  related to 4 proc nor the kernel version.

All filesystems more or less show those differences.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
