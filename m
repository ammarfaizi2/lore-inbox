Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUI2KJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUI2KJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 06:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUI2KJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 06:09:58 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:18622 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S268294AbUI2KJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 06:09:57 -0400
Date: Wed, 29 Sep 2004 17:17:44 +0800
From: Joshua Ross <jrxr@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: Data corruption on IDE disk via USB.
Message-Id: <20040929171744.0b3a0773.jrxr@softhome.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an external hard drive with an IDE interface.  This goes through
a USB2.0-IDE adapter.  I'm getting silent corruption of data when
copying big files to the drive, but not consistently.  The partition was
originally ext3, but I'm now mounting it ext2 and sync.  Still getting
the corruption.  

Running on: Linux albert 2.6.8.1 #5  i686 Mobile Intel(R) Pentium(R) 4 -
M CPU 1.80GHz GenuineIntel GNU/Linux.

Any suggestions about stopping the corruption/diagnosing what's going
on?

Thanks.

p.s.  Please cc me in replies since I read the list through hypermail.

