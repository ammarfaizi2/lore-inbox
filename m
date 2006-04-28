Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWD1RA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWD1RA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWD1RA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:26 -0400
Received: from [198.99.130.12] ([198.99.130.12]:30936 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751423AbWD1RA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:26 -0400
Message-Id: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/6] UML - Small patches for 2.6.17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Apr 2006 12:01:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are 2.6.17 material.  They are small bug fixes and cleanups - 
the one functional change, skas0 support for 2G/2G hosts, is innocuous and 
tested.

				Jeff

