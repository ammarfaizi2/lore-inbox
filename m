Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUBFXfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUBFXfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:35:24 -0500
Received: from vsmtp14.tin.it ([212.216.176.118]:56812 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S265799AbUBFXef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:34:35 -0500
Message-ID: <3FE986970091192E@vsmtp14.tin.it> (added by postmaster@virgilio.it)
From: Marco Gulino <rockman81@tin.it>
Subject: Multimedia Keyboard (no scancodes?)
To: linux-kernel@vger.kernel.org
Date: Sat, 07 Feb 2004 00:34:16 +0100
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
 Where i was using the 2.4.x kernel my multimedia keyboard was sending the
 special keys to usermode apps, allowing to control them and assign some
 functions.
 Now i'm on 2.6.2 and some of these keys are not working... no scancode,
 nothing, either looking with dmesg or xev.
 It's like the kernel is "filtering" the unknown scancodes and delete them.
 Ideas?
 Thanks anyway.
 p.s.: the 2.4 kernel i was using was a standard bareacpi.i from SlackWare
 9.1, while the config for 2.6 was strongly edited. However i didn't see any
 option for keyboards, so i don't think it's a config fault.
 p.p.s.: sorry for bad english :P
