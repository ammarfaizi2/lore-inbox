Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUGZBkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUGZBkN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGZBkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:40:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:60833 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264808AbUGZBkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:40:05 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
Organization: Deban GNU/Linux Homesite
In-Reply-To: <87smbfr5qe.fsf@osu.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BouTC-0001Dx-00@calista.eckenfels.6bone.ka-ip.net>
Date: Mon, 26 Jul 2004 03:40:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <87smbfr5qe.fsf@osu.edu> you wrote:
> Thanks, that looks pretty useful, at least to force the I/O to make it
> outside the kernel.  I'm still getting cache hits for some read tests
> though

This might be due to read ahead... how  do you check the cache hits, what
read patterns do you have?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
