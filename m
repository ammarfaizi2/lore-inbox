Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVAWQrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVAWQrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 11:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVAWQrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 11:47:25 -0500
Received: from mirage.confident-solutions.de ([80.190.233.175]:17081 "EHLO
	mirage.confident-solutions.de") by vger.kernel.org with ESMTP
	id S261325AbVAWQrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 11:47:22 -0500
Date: Sun, 23 Jan 2005 17:46:59 +0100
From: Peter Geerds <TheGnome@t-online.de>
To: linux-kernel@vger.kernel.org
Subject: Problem: usb-modem and kernel 2.6.10
Message-ID: <20050123164659.GA21909@thegnome>
Reply-To: Peter Geerds <TheGnome@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Comment: Don't send unnecessarily HTML-coded mails!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a great problem with the kernel 2.6.10
(www.kernel.org) and my usb-modem ELSA Microlink ISDN
Office. To surf in internet, I use wvdial (version 1.54.0).
The idle-time ist set to 300 sec.  This works very fine, but
the modem reaches the idle-time independet of traffic. 
For example: I get my mails and the modem hangs up after 300
sec with no error:

/var/log/message

pppd[9913]: Terminating connection due to lack of activity.

I hope, you can help me. TX

cu
PeeGee

PS: Sorry - my English is very bad!

