Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263227AbSJCK3D>; Thu, 3 Oct 2002 06:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263229AbSJCK3D>; Thu, 3 Oct 2002 06:29:03 -0400
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:30216 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263227AbSJCK3C>; Thu, 3 Oct 2002 06:29:02 -0400
Date: Thu, 3 Oct 2002 11:34:14 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: block device size in 2.5
Message-ID: <20021003103414.GA11966@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is the total size of a block device held in struct gendisk rather
than struct block_device ?

Joe Thornber
