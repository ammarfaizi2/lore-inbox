Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTFIO2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFIO0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:26:00 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:54542 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264393AbTFIOYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:24:24 -0400
Date: Mon, 9 Jun 2003 15:38:04 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] dm: Remove an old FIXME
Message-ID: <20030609143804.GH11331@fib011235813.fsnet.co.uk>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an old FIXME.
--- diff/drivers/md/dm.c	2003-06-09 15:05:35.000000000 +0100
+++ source/drivers/md/dm.c	2003-06-09 15:07:03.000000000 +0100
@@ -281,9 +281,6 @@
 	sector_t offset = sector - ti->begin;
 	sector_t len = ti->len - offset;
 
-	/* FIXME: obey io_restrictions ! */
-
-
 	/*
 	 * Does the target need to split even further ?
 	 */
