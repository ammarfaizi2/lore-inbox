Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUEORkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUEORkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUEORkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 13:40:42 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:22413 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264716AbUEORki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 13:40:38 -0400
Message-ID: <40A6561B.9050800@hotmail.com>
Date: Sat, 15 May 2004 13:40:43 -0400
From: Colin <cwvca_spammr@hotmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ASUS P4P800 Deluxe motherboard and 1016 BIOS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone else have problems starting linux with the 1016 BIOS of an 
ASUS P4P800 Deluxe motherboard?

I tried to start Knoppix 3.4 with this BIOS and it would freeze right 
after the initial boot screen.  I also use Debian and it freezes when 
booting up.  I'm using version 1014 of the BIOS and it seems to work 
fine.  I didn't try the 1015 version because 1016 came less than a month 
later which suggests there was something wrong with 1015.

I suspect that the BIOS changes with the USB stuff is what's causing the 
boot failure because they've done a lot of changes in that area between 
1014 and 1016.  Actually, the USB stuff works a bit better in Windows 
with 1016 because I can see my USB devices with it without switching the 
USB mode to FastSpeed (USB 1.1) in the BIOS but all USB devices appear 
as 1.1 devices even though some of them are 2.0 device.  Linux with the 
1014 version works fine with USB devices (both 1.1 and 2.0 devices).

Any ideas?
