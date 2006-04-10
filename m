Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWDKAgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWDKAgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWDKAgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:36:13 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:7908 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932214AbWDKAgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:36:10 -0400
Message-Id: <200604102336.k3ANauR6006838@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/3] UML - small fixes and cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Apr 2006 19:36:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are bug fixes and code tidying, except for the /dev/shm one, which
changes where UML creates its physical memory file.  They are 2.6.17 material.

				Jeff

