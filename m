Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267226AbUGMXYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267226AbUGMXYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267227AbUGMXYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:24:03 -0400
Received: from quechua.inka.de ([193.197.184.2]:64471 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S267226AbUGMXYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:24:01 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040713222411.GA1035@hh.idb.hist.no>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BkWcx-0008RS-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 14 Jul 2004 01:23:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040713222411.GA1035@hh.idb.hist.no> you wrote:
> With this approach you don't need to zero a half-written
> block after a crash, which means you destroy less data.

which  does not change the fact that the block contains zeros if it was not
written. :)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
