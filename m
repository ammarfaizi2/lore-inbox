Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWJ3UFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWJ3UFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWJ3UFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:05:07 -0500
Received: from [198.99.130.12] ([198.99.130.12]:13454 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030587AbWJ3UFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:05:05 -0500
Message-Id: <200610302102.k9UL2vmg006229@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/3] UML - Small compile fixes and a cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Oct 2006 16:02:55 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following three patches are for 2.6.19 - they fix two build problems and
add the INITCALLs change to UML.

				Jeff

