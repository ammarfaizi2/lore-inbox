Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTFPVeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTFPVeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:34:02 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:38103 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264340AbTFPVeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:34:00 -0400
Date: Mon, 16 Jun 2003 22:48:33 +0100
Message-Id: <200306162148.h5GLmXsN002578@telekon.davesnet>
From: dave.bentham@ntlworld.com
Subject: kernel 2.4.21 crash
To: linux-kernel@vger.kernel.org
X-Originating-IP: 192.168.0.1
X-Mailer: Webmin 0.990
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1055800113"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--bound1055800113
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

I upgraded my kernel on a Mandrake 9.0 base from 2.4.20 to the new 2.4.21 tonight - built from source patches as I always do; followed by reinstalling the NVidia drivers and ALSA.

But there seems to be a major failure when the computer just stops with no warning. Two scenarios that seem to repeat it include starting Loki's Heretic2 off, and mounting the CDRW drive via WindowMaker dock app. I cannot do anything when this happens; can't hotkey out of X, can't telnet to it from my other networked PC. I have to power down and back up.

It seems to be a few seconds after the trigger that the lock up occurs, and also it starts flashing the keyboard Caps Lock and Scroll Lock LEDs in step at about 1 Hz. I'm sure its trying to tell me something...

Thanks in advance

Dave

--bound1055800113--
