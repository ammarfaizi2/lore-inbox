Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbTGOIhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266907AbTGOIhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:37:18 -0400
Received: from mail.muffin.org ([193.109.237.8]:1531 "EHLO mail.muffin.org")
	by vger.kernel.org with ESMTP id S266896AbTGOIhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:37:17 -0400
Subject: Synaptic problems on Vaio GRX516MD
From: Erwin Rol <mailinglists@erwinrol.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058259115.3600.11.camel@erwin.fe.think>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Jul 2003 10:51:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

i am having problems with the synaptic touchpad on my vaio GRX516MD.
Under 2.4 it works normally (also with the synaptic XFree module) but
under 2.5 and 2.6 it just doesn't work. The XFree module complains that
/dev/psaux isn't a synaptic device.

Also when i press a key on the keyboard it just shows one time, but when
i touch the synaptic pad at the time of pressing the key the key gets
repeated 5 or 6 times  (after releasing the key). 

- Erwin

Jul 14 23:28:22 vaio kernel: mice: PS/2 mouse device common for all mice
Jul 14 23:28:22 vaio kernel: Synaptics Touchpad, model: 1
Jul 14 23:28:22 vaio kernel:  Firware: 5.9
Jul 14 23:28:22 vaio kernel:  Sensor: 37
Jul 14 23:28:22 vaio kernel:  new absolute packet format
Jul 14 23:28:22 vaio kernel:  Touchpad has extended capability bits
Jul 14 23:28:22 vaio kernel:  -> multifinger detection
Jul 14 23:28:22 vaio kernel:  -> palm detection
Jul 14 23:28:22 vaio kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
Jul 14 23:28:22 vaio kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 14 23:28:22 vaio kernel: input: AT Set 2 keyboard on isa0060/serio0
Jul 14 23:28:22 vaio kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

