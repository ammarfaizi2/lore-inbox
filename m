Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUECKVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUECKVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 06:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUECKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 06:21:22 -0400
Received: from web41314.mail.yahoo.com ([66.218.93.63]:24210 "HELO
	web41314.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263626AbUECKVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 06:21:21 -0400
Message-ID: <20040503102120.23966.qmail@web41314.mail.yahoo.com>
Date: Mon, 3 May 2004 12:21:20 +0200 (CEST)
From: =?iso-8859-1?q?Joerg=20Pommnitz?= <pommnitz@yahoo.com>
Subject: Software based unplug of USB device?
To: linux-usb-users@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello listees,
we are struggling with a 3rd party USB device. It comes with its own
firmware and its own Linux USB serial drivers. Unfortunately the
communication between the device and the user application seems to break
down from time to time. This situation can easily be resolved by
unplugging and then re-plugging the device. Unfortunately this requires
manual intervention.
While resolving the real issue would be the preferred way to deal with
this problem, we would settle for a way to do a software unplug/re-plug.
Can this be done at all? If so, is there a tool to do this?

A detailed description of our environment:
* Linux 2.4.21 with USB OHCI driver
* Natsemi Geode integrated CPU/Chipset

Thanks in advance
  Joerg


	

	
		
Mit schönen Grüßen von Yahoo! Mail - http://mail.yahoo.de
