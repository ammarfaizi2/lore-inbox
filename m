Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTKQU1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 15:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKQU1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 15:27:44 -0500
Received: from pop.gmx.net ([213.165.64.20]:12737 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261731AbTKQU1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 15:27:43 -0500
X-Authenticated: #2034091
Message-ID: <2523214.1069100860170.JavaMail.jpl@remotejava>
Date: Mon, 17 Nov 2003 21:27:40 +0100 (CET)
From: Jan Ploski <jpljpl@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-testX and pppd/pppoe stuck after connecting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is for the archive and to close the thread which I started on
Sat, 25 Oct 2003.

I resolved my problem by recompiling the kernel with a different set
of enabled PPP options. More specifically, I appear to have enabled
*too many* options when I switched from 2.4 to 2.6. Therefore, I should
have attributed the problems that I encountered to differing kernel
configurations, not necessarily to different kernel versions.

pppd is working fine now for me. Unfortunately, I don't remember
the exact set of options that caused trouble. Nevertheless, if anyone
ever experiences similiar symptoms, this message might provide just
enough information to push their solution attempts in the right
direction.

Best regards -
Jan Ploski

