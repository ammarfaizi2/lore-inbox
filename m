Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUHQHtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUHQHtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268133AbUHQHtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:49:51 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:48488 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S268137AbUHQHtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:49:49 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch is this?
Date: Tue, 17 Aug 2004 03:49:44 -0400
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408170349.44626.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 mice: PS/2 mouse device common for all mice
input: IBM PC110 TouchPad at 0x15e0 irq 10 <----------------------------- This is new
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
Firmware: 5.9
Sensor: 44
new absolute packet format
Touchpad has extended capability bits
  -> multifinger detection
  -> palm detection
  -> pass-through port
 input: SynPS/2 Synaptics TouchPad on isa0060/serio1
 serio: Synaptics pass-through port atisa0060/serio1/input0

Which patch is this? its nice but I don't see any ability (yet) to control its sensitivity (especially in KDE!). Upon using 2.6.8-rc4-bk2 there was no such device (you could not touch the pad as a button).

Shawn.

