Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261658AbSJAOBW>; Tue, 1 Oct 2002 10:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJAOBW>; Tue, 1 Oct 2002 10:01:22 -0400
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:40453 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261658AbSJAOBW>; Tue, 1 Oct 2002 10:01:22 -0400
Date: Tue, 1 Oct 2002 15:06:39 +0100
To: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021001140639.GA25624@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bk://device-mapper.bkbits.net/2.5-remove-lvm

This large patch completely removes LVM from the 2.5 tree.  Please
apply.  Yes it really has spread as far as linux/list.h and
linux/kdev_t.h !

- Joe Thornber
