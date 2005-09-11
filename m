Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVIKXYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVIKXYr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVIKXYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:24:47 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27667 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750998AbVIKXYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:24:46 -0400
Date: Mon, 12 Sep 2005 01:24:38 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, grant_lkml@dodo.com.au
Subject: Linux-2.4.31-hf5
Message-ID: <20050911232438.GA13086@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here comes the fifth hotfix for 2.4.31. It basically is a merge of things
which have popped up since 2.4.32-pre3. Nothing really scary, this one is
more opportunist than absolutely needed. Andrea's fix is worth the upgrade
for people running x86 with more than 4 GB RAM though.

As usual, 3 kernels have been released : 2.4.31-hf5, 2.4.30-hf8, 2.4.29-hf15.
Starting with next release, there will only be one tgz for all kernels,
because duplicating lots of common parts is rather boring (and will be even
more when 2.4.32 will be included). But the patches will still be released
individually of course.

The files have been uploaded here :

    http://linux.exosec.net/kernel/2.4-hf/

Only 2.4.31-hf5 has been compiled. Please let Grant Coady the time to build
and test them all before rushing to his report site :

    http://bugsplatter.mine.nu/test/linux-2.4/

Regards,
Willy

