Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbTJZQlq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTJZQlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:41:46 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:34437 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S263297AbTJZQlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:41:45 -0500
Message-ID: <32929.68.105.173.45.1067187158.squirrel@mail.mainstreetsoftworks.com>
Date: Sun, 26 Oct 2003 11:52:38 -0500 (EST)
Subject: Compile patch for x86_64 + acpi
From: "Brad House" <brad_mssw@gentoo.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.6.0-test8-bk1 or so, compilation broke on x86_64 with acpi
enabled.  A patch that fixes this can be found at:

http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-amd64-acpi-compilefix.patch

This compiles and tests out fine.

Please CC me on any replies!

-Brad House
brad_mssw@gentoo.org
Gentoo Linux




