Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUHQBAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUHQBAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUHQBAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:00:33 -0400
Received: from mail-gw4.njit.edu ([128.235.251.32]:8386 "EHLO
	mail-gw4.njit.edu") by vger.kernel.org with ESMTP id S268058AbUHQBA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:00:28 -0400
Date: Mon, 16 Aug 2004 21:00:23 -0400 (EDT)
From: Rahul Jain <rbj2@oak.njit.edu>
To: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel recompilation error
Message-ID: <Pine.GSO.4.58.0408162058310.17241@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the first time I am seeing this error while recompiling the
kernel. Could someone plz explain what it means and how to fix it.

I get this error message when I run the command 'make install'. Till this
point everything else works out properly.

Error Message
-------------
All of your loopback devices are in use.
mkinitrd failed

The commands run before this were
make mrproper
make menuconfig
make dep
make bzImage
make modules and
make modules_install

Thanks,
Rahul.

