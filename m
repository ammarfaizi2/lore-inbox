Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUHOQRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUHOQRH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 12:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266827AbUHOQRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 12:17:07 -0400
Received: from foxxy.triohost.com ([65.110.50.10]:16850 "EHLO
	foxxy.triohost.com") by vger.kernel.org with ESMTP id S266824AbUHOQRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 12:17:05 -0400
Date: Sun, 15 Aug 2004 12:17:29 -0400 (EDT)
From: Sindi Keesan <keesan@iamjlamb.com>
X-X-Sender: keesan@foxxy.triohost.com
To: linux-kernel@vger.kernel.org
Subject: mdacon and scroll buffer 
Message-ID: <Pine.LNX.4.44.0408151215040.5391-100000@foxxy.triohost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the only mail list I could find that discussed mdacon.

Mdacon appears to have no Scroll_Backward or _Forward feature (scroll
buffer) like vgacon does (shift Page Up or shift Page Down).  I use
mdacon.o with a 2-monitor system.  Is there something in vgacon.c I could
copy over to mdacon.c so I could try to compile my own version with scroll
buffer?

I have no programming experience but a friend could help.

Sindi Keesan

