Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVBYOUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVBYOUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVBYOUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:20:19 -0500
Received: from 0x63.nu ([62.65.122.157]:39648 "EHLO gagarin.0x63.nu")
	by vger.kernel.org with ESMTP id S262704AbVBYOUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:20:11 -0500
Date: Fri, 25 Feb 2005 15:20:07 +0100
From: Christoffer Gurell <orbit@0x63.nu>
To: linux-kernel@vger.kernel.org
Subject: problem with ps2 and trackpoint in 2.6.11-rc4
Message-ID: <20050225142007.GA19743@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I hope trackpoint is the correct word. It is a small "joy"stick like
 pointer located between the keys of the keyboard on many laptops)

As of 2.6.11-rc4 the trackpoint on my Dell Latitude d800 no longer
works. 
The d800 is equiped with both a trackpoint and a touchpad and up to 2.6.11-rc3 
both worked fine with the kernel ps2 driver.

The touchpad still works in 2.6.11-rc4 and rc5 but the trackpoint does
nothing.

dmesg gives me the following in both rc3 and rc4.

mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
ALPS Touchpad (Dualpoint) detected
input: AlpsPS/2 ALPS TouchPad on isa0060/serio1

I am not registered on the mailinglist so please cc replies.

 / Christoffer Gurell
