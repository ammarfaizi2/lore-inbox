Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTK3WBy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTK3WBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:01:42 -0500
Received: from misc-out.tuxfamily.net ([80.67.180.68]:56775 "EHLO
	mx1.tuxfamily.net") by vger.kernel.org with ESMTP id S261188AbTK3WBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:01:16 -0500
Message-ID: <1070229674.3fca68aaea488@webmail.tuxfamily.org>
Date: Sun, 30 Nov 2003 23:01:14 +0100
From: alexis@linuxcode.eu.org
To: linux-kernel@vger.kernel.org
Subject: Bug with extraversion in kernel-2.4.23
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2
X-Originating-IP: 81.57.34.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm 14 years old, and i'm french. When I've making package for my distribution,
FNux, of the 2.4.23, I see a big problem.

The extraversion variable of the Makefile is very badly interpreted.
When the kernel is installed, I have 2 directory of modules :
/lib/modules/2.4.23
/lib/modules/2.4.23-fnux (my extraversion is -fnux)

This is a very problem for the linux distributions, beacause the EXTRAVERSION is
often used.

Thanks
Alexis ROBERT
