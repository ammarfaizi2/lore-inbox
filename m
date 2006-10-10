Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030603AbWJJWgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbWJJWgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbWJJWgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:36:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49282 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030603AbWJJWgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:36:46 -0400
To: torvalds@osdl.org
Subject: [patches] misc endianness annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQDN-0008Tj-RA@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:36:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted trivial endianness annotations that had been sitting in my tree
for a long, long time...
