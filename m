Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTIOPbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTIOPbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:31:48 -0400
Received: from dmesg.printk.net ([212.13.197.101]:42629 "EHLO dmesg")
	by vger.kernel.org with ESMTP id S261250AbTIOPbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:31:47 -0400
Message-ID: <60603.62.173.87.60.1063639907.squirrel@mail.printk.net>
Date: Mon, 15 Sep 2003 16:31:47 +0100 (BST)
Subject: /proc/sys sysrq
From: "Jon Masters" <jcm@printk.net>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <jcm@jonmasters.org>
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Someone recently posted a message to Linux Managers about rebooting a box
with a failed drive and no serial console from a remote location. It
turned out in that instance that there was another drive and enough
working to copy a simple reboot binary to it.

Anyway I was wondering whether there is an official "alternative sysrq" in
/proc/sys or if it would be worth me writing a patch to add things like a
reboot entry one could cat "feeldead" to or whatever...is this even worth
doing or been done?

Jon.



