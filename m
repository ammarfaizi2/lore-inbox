Return-Path: <linux-kernel-owner+w=401wt.eu-S1422666AbXAESst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbXAESst (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbXAESsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:48:17 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:34878 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422666AbXAESrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:47:42 -0500
Message-Id: <200701051842.l05IgBFb004602@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/9] UML - Locking fixes and code cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2007 13:42:10 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Post-2.6.20 material.

The locking fixes are mostly commenting the lack of locking or are making
things const.

There's a bunch of code cleanup - elimination of dead code, unused parameters,
and unused structure fields - and some formatting fixes.

				Jeff



