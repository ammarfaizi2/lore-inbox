Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbTJCFwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 01:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTJCFwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 01:52:50 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:59593 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S263686AbTJCFwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 01:52:50 -0400
Date: Fri, 3 Oct 2003 08:52:48 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: idt change in a running kernel? what locking?
Message-ID: <Pine.LNX.4.58.0310030850110.10930@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What may happen if I modify idt on a running kernel?
It's lock_kernel enough?

Of course that the new location contain a valid idt table.

Thank you very much!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
