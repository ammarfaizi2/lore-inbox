Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTLEXw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbTLEXw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:52:26 -0500
Received: from [12.177.129.25] ([12.177.129.25]:4292 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S264305AbTLEXwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:52:25 -0500
Message-Id: <200312060005.hB605LAv008258@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: "Brad Parker" <parker@citynetwireless.net>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: Linux 2.6.0-test10 
In-Reply-To: Your message of "Sun, 23 Nov 2003 21:47:17 CST."
             <011101c3b23d$aa41e420$fd01000a@bp> 
References: <Pine.LNX.4.44.0311231804170.17378-100000@home.osdl.org>  <011101c3b23d$aa41e420$fd01000a@bp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Dec 2003 19:05:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parker@citynetwireless.net said:
> I get this trying to compile for the user-mode-linux arch: 

> include/asm/arch/system.h:7: asm/cpufeature.h: No such file or directory 

Linus hasn't taken any patches from me in a long time, so you need to apply
a separate UML patch which brings the Linus tree up to date.  Until I get
a test10/test11 patch ready, the test9 patch seems to work OK with a small
tweak.

				Jeff

