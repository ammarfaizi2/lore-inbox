Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTJZSDg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTJZSDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:03:36 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:55685 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S263386AbTJZSDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:03:35 -0500
Message-ID: <33092.68.105.173.45.1067192069.squirrel@mail.mainstreetsoftworks.com>
Date: Sun, 26 Oct 2003 13:14:29 -0500 (EST)
Subject: [patch 2.6.0-test9] enable pci id for promise pdc20378 in new libata driver
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

Missing ID for the promise 20378 controller that is present on many
x86_64 mobos. Simple patch to add it, and it's been tested and works
fine.

The patch can be found here:
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/2.6.0-test9-promise20378.patch

Patch/Testing done by Caleb Shay <caleb@webninja.com>

Please CC me on any replies!

-Brad House
brad_mssw@gentoo.org
Gentoo Linux





