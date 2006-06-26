Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWFZFMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWFZFMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWFZFMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:12:15 -0400
Received: from xenotime.net ([66.160.160.81]:28631 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751184AbWFZFMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:12:14 -0400
Date: Sun, 25 Jun 2006 22:14:59 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: nathans@sgi.com, xfs@oss.sgi.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: XFS warning (2.6.17-git9)
Message-Id: <20060625221459.7e72bbad.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


was a new (second) parameter added?

on xfs_file_close:
fs/xfs/linux-2.6/xfs_file.c:555: warning: initialization from incompatible pointer type
fs/xfs/linux-2.6/xfs_file.c:580: warning: initialization from incompatible pointer type

---
~Randy
