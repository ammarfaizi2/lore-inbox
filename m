Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUKAG5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUKAG5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 01:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUKAG5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 01:57:23 -0500
Received: from main.gmane.org ([80.91.229.2]:62441 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261416AbUKAG5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 01:57:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Bevand <bevand_m@epita.fr>
Subject: [rc4-amd64] RC4 optimized for AMD64
Date: Mon, 1 Nov 2004 06:57:17 +0000 (UTC)
Message-ID: <cm4moc$c7t$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ivry-1-81-57-179-18.fbx.proxad.net
User-Agent: slrn/0.9.8.0pl1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just published a small paper about optimizing RC4 for
AMD64 (x86-64). A working implementation is also provided:

  http://epita.fr/~bevand_m/papers/rc4-amd64.html

Kernel people may be interested given the fact that Linux
already implements RC4.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.

