Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVKUWBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVKUWBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVKUWBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:01:08 -0500
Received: from compunauta.com ([69.36.170.169]:48271 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S1751074AbVKUWBH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:01:07 -0500
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: /dev/sr0 not ready, but working
Date: Mon, 21 Nov 2005 16:00:51 -0600
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511211600.51338.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I use my external case as Firewire or USB 2.0 I got the error on the 
kernel syslog:
sr 0:0:0:0: Device not ready.
last message repeated 187 times

Same using amdtp FireWire Driver and usb-storage driver.

but the drive keeps writing and the media finish and close as espected on the 
95% of times, the other 5% :(.

This does not happen when the drive is on IDE interface, my kernel verison is: 
2.6.14/12, and the Drive is a Pioneer DVR110D and A07 both the same onto an 
ADS Tech BOX.

Regards
-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
