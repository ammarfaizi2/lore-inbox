Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTETFht (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 01:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTETFht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 01:37:49 -0400
Received: from [203.94.130.164] ([203.94.130.164]:1669 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S263578AbTETFhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 01:37:48 -0400
Date: Tue, 20 May 2003 15:27:46 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk12 fails to boot
Message-ID: <Pine.LNX.4.44.0305201523050.17832-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Continuing problem since 2.5.68

More details at 
<http://bad-sports.com/~brett/bugreports/kernel/2.5.69-failboot/>
and 
<http://bugzilla.kernel.org/show_bug.cgi?id=677>

(including .config and steps taken to diagnose)

summary:

kernel refuses to boot
if vga=ask is used, it correctly asks for the resolution
changes to that resolution
and hangs

p75 laptop
problem occured with gcc-3.2.2 and 3.3
early_printk patch did not print anything to screen

i'm at a loss as to how to diagnose/fix
and would appreciate help and suggestions

thanks,

	/ Brett

