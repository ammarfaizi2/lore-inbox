Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbUCOQBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbUCOQBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:01:13 -0500
Received: from 220-244-186-86-qld.tpgi.com.au ([220.244.186.86]:59943 "EHLO
	dawn") by vger.kernel.org with ESMTP id S262618AbUCOQBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:01:12 -0500
Subject: RadeonFB
From: Oystein Haare <lkml-account@mazdaracing.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1079366460.853.3.camel@dawn>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 02:01:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having some problems with radeon framebuffer and the newer kernels.
I have a HP/Compaq nx7010 laptop computer, that is supposed to have a
Radeon 9200 graphics board.

Now.. in 2.6.1, it seems to work ok. But in 2.6.4 it just flickers alot.
Are there anyone else than me experiencing this problem? 

This is what it outputs:

radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz,
System=220.00 MHz
Non-DDC laptop panel detected
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: Samsung LTN150P1-L02    
radeonfb: detected LVDS panel size from BIOS: 1400x1050
radeondb: BIOS provided dividers will be used
radeonfb: Assuming panel size 1400x1050
radeonfb: Power Management enabled for Mobility chipsets
radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB

Could the flickering have something to do with the fact that the lcd
panel on my laptop can only do 1280x800 resolution? Or doesn't the
1400x1050 have anything to do with resolution at all?

PS: Please CC replies to me as I am not on the list.

thanks 

