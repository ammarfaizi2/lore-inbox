Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTKASX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 13:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTKASX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 13:23:28 -0500
Received: from mail7.speakeasy.net ([216.254.0.207]:59304 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S263351AbTKASX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 13:23:27 -0500
From: Alexander Chacon <chacona@mechanus.org>
Message-ID: <1067711134.659a9dpacz4s@webmail.mechanus.org>
Date: Sat,  1 Nov 2003 12:25:34 -0600
To: linux-kernel@vger.kernel.org
Subject: Modular ipv4 inquiries...
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 196.40.10.252
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I would like to know a few things about making the ipv4 code modular. I've been
working on a school assignment that requires implementing tunneling, but first
ipv4 must be modularized... it needs to be done using kernel 2.4.20

I see Eric Schenk tried to do it on an earlier kernel version (
http://www.cs-ipv6.lancs.ac.uk/ipv6/mail-archive/LinuxNetdev/1997-03/0218.html
), a few years ago. What should I consider for a start, and how hard can it be
in the end?

I've experienced a lot of undefined symbol references which are linked to core
kernel files!, isn't there a way to access these symbols from the module into
the kernel while executing?

Thanks in advance
Alexander Chacon
