Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVB0SC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVB0SC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVB0RwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:52:23 -0500
Received: from cantor.suse.de ([195.135.220.2]:5539 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261453AbVB0RXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:23:04 -0500
Message-Id: <20050227165954.566746000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 17:59:54 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [nfsacl v2 00/16] NFSACL protocol extension for NFSv3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the proper nfsacl patchset against 2.6.11-rc5. Again, these are
the open issues:

 - Not sure what do do about the Solaris compatibility hack. It's
   ugly no matter how we hide it, so I'll probably keep it the way
   it is now,

 - Matt's heapsort is defective, so I'm not using it, yet.

Regards,
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

