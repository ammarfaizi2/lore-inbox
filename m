Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVBBQ3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVBBQ3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVBBQ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:27:21 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:12461 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262395AbVBBQSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:18:24 -0500
Message-Id: <20050202161340.660712000@blunzn.suse.de>
Date: Wed, 02 Feb 2005 17:13:40 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Chris Mason <mason@suse.de>
Subject: [RFC][PATCH 0/3] Access Control Lists for tmpfs and /dev/pts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a set of three patches which implement some general
infrastructure and on top of that, acls for tmpfs and /dev/pts files.
We may want to factor out some of the current ext2 and ext3 acl code
and use the generic layer instead. Comments welcome.

Regards,
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

