Return-Path: <linux-kernel-owner+w=401wt.eu-S1754094AbXAATwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbXAATwd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbXAATwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:52:32 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52675 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbXAATwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:52:32 -0500
Message-Id: <200701011947.l01Jl6qs020741@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/8] UML - Locking fixes and code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2007 14:47:06 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As before, this is post-2.6.20 material.

These patches fix locking, style and whitespace problems, and make small
code cleanups.

				Jeff

