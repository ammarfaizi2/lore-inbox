Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTFZP25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTFZP25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 11:28:57 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:676 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261944AbTFZP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 11:28:55 -0400
Date: Fri, 27 Jun 2003 01:48:29 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.73-bk4: synaptics touchpad failure
Message-ID: <20030626154829.GA543@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun 27 01:39:33 theirongiant kernel: mice: PS/2 mouse device common for all mice
Jun 27 01:39:33 theirongiant kernel: synaptics reset failed
Jun 27 01:39:33 theirongiant last message repeated 2 times
Jun 27 01:39:33 theirongiant kernel: Synaptics Touchpad, model: 1
Jun 27 01:39:33 theirongiant kernel:  Firware: 4.1
Jun 27 01:39:33 theirongiant kernel:  Sensor: 8
Jun 27 01:39:33 theirongiant kernel:  new absolute packet format
Jun 27 01:39:33 theirongiant kernel: input: Synaptics Synaptics TouchPad on isa0060/serio1
Jun 27 01:39:33 theirongiant kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 27 01:39:33 theirongiant kernel: input: AT Set 2 keyboard on isa0060/serio0
Jun 27 01:39:33 theirongiant kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

gpm would not pick up any mouse movements from the touchpad.

On reboot into 2.5.72 the touchpad only works for moving the mouse. No
amount of tapping will illicit a click. 8(

This is a synaptics touchpad in a Gateway *spit* XL5300 *spit* laptop.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
