Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUBDF61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 00:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUBDF60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 00:58:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:38016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265718AbUBDF6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 00:58:25 -0500
Date: Tue, 3 Feb 2004 21:56:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] add syscalls.h (ver. ~4)
Message-Id: <20040203215605.497b3af3.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now builds on i386 (P4) and ia64.
Booted on i386/P4.

Patch is now against 2.6.2-rc3...
Patch is at
  http://developer.osdl.org/rddunlap/syscalls/2.6.2-rc3-syscalls-v4.diff
(99 KB)

Comments?

--
~Randy
