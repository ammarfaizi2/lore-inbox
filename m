Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUFNWmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUFNWmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUFNWmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:42:11 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:53684 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264560AbUFNWmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:42:03 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jun 2004 15:41:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [tool] qlnx-psets configuration tool
Message-ID: <Pine.LNX.4.58.0406141531570.7640@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am one of the heavy users of the kernel CVS repository on kernel.org 
(using rsync) and I also find cvsps a very valuable tool to bring order in 
the CVS caos. Since the operations that I find myself doing on such data 
are extremely repetitive, and CVS doesn't quite cut it, I put together a 
simple hack to help me in the automation of the process:

http://www.xmailserver.org/qlnx-psets.html

Because of its use of caches, it can build custom configuration pretty 
quickly. For example, in my machine when used together with the 
--hard-links option, it can build a configuration in less than 5 seconds.




- Davide

