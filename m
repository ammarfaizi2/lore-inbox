Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTFYWyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbTFYWyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:54:12 -0400
Received: from cmu-24-35-32-166.mivlmd.cablespeed.com ([24.35.32.166]:1796
	"EHLO lap.molina") by vger.kernel.org with ESMTP id S265145AbTFYWyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:54:10 -0400
Date: Wed, 25 Jun 2003 19:06:40 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
Subject: Re: Synaptics support kills my mouse
Message-ID: <Pine.LNX.4.44.0306251857390.921-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realized I forgot to include some useful information.  Following are the 
relevant boot messages.  It appears to correctly detect my touchpad but 
doesn't give me a mouse cursor, even in text consoles.

Jun 25 18:41:26 lap kernel: mice: PS/2 mouse device common for all mice
Jun 25 18:41:26 lap kernel: Synaptics Touchpad, model: 1
Jun 25 18:41:26 lap kernel:  Firware: 4.6
Jun 25 18:41:26 lap kernel:  Sensor: 15
Jun 25 18:41:26 lap random: Initializing random number generator:  
succeeded
Jun 25 18:41:26 lap kernel:  new absolute packet format
Jun 25 18:41:26 lap kernel:  Touchpad has extended capability bits
Jun 25 18:41:26 lap kernel:  -> four buttons
Jun 25 18:41:26 lap kernel:  -> multifinger detection
Jun 25 18:41:26 lap kernel:  -> palm detection
Jun 25 18:41:26 lap kernel: input: Synaptics Synaptics TouchPad on 
isa0060/serio1
Jun 25 18:41:26 lap kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jun 25 18:41:26 lap kernel: input: AT Set 2 keyboard on isa0060/serio0
Jun 25 18:41:26 lap kernel: serio: i8042 KBD port at 0x60,0x64 irq 1



