Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUB1XsY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 18:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbUB1XsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 18:48:24 -0500
Received: from elektra.telenet-ops.be ([195.130.132.49]:31136 "EHLO
	elektra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261943AbUB1XsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 18:48:22 -0500
Date: Sun, 29 Feb 2004 00:47:44 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.3 pcwd_usb-watchdog
Message-ID: <20040229004744.E30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

please do a

	bk pull http://linux-watchdog.bkbits.net/linux-2.6-watchdog

This will update the following files:

 drivers/char/watchdog/Kconfig    |   22 +
 drivers/char/watchdog/Makefile   |    3 
 drivers/char/watchdog/pcwd_usb.c |  810 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 834 insertions(+), 1 deletion(-)

through these ChangeSets:

<wim@iguana.be> (04/02/29 1.1628)
   [WATCHDOG] v2.6.3 pcwd_usb-watchdog
   
   Add the Berkshire Products USB-PC Watchdog driver


The ChangeSets can also be looked at on:
	http://linux-watchdog.bkbits.net:8080/linux-2.6-watchdog

Greetings,
Wim.

