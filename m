Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVC3SMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVC3SMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbVC3SMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:12:12 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:61330 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S262375AbVC3SLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:11:18 -0500
To: dsd@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: rootdelay
From: davidw@dedasys.com (David N. Welton)
Supersedes: <87hditj9ls.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Date: 30 Mar 2005 20:05:36 +0200
Message-ID: <87wtrphuvj.fsf@dedasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Please CC replies to me, thanks! ]

Hi, I was looking at your patch:

http://lkml.org/lkml/2005/1/21/132

Very small, which is nice.

I was wondering if there were any interest in my own efforts in that
direction:

http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch

which is far more intrusive, and perhaps isn't good kernel programming
style, but, on the other hand, is the optimal solution in terms of
boot time because it wakes up the boot process right when the device
comes on line.

Since I saw your patch included, it looks like there is interest in
this, and I'd toot my own horn once more before just leaving my patch
to the bit rot of the ages...

Thanks!
-- 
David N. Welton
 - http://www.dedasys.com/davidw/

Apache, Linux, Tcl Consulting
 - http://www.dedasys.com/

Got the right list this time too...:-/
