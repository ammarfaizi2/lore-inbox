Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270538AbTGNFrU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270539AbTGNFrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:47:20 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([24.192.190.108]:39809
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S270538AbTGNFrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:47:18 -0400
Date: Mon, 14 Jul 2003 02:01:58 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Strange issue with keyboard in 2.5
Message-ID: <Pine.LNX.4.44.0307140200460.10141-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.


When I press certain key combinations I get this logged.

Also if I hold down a key sometimes it gets 'stuck' and repeats forever
until I break the repeat.

Why is this happening in 2.5?

Is it due to my KVM or something else?

Thanks,

Shawn S.

