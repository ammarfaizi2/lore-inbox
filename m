Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUAZKWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 05:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUAZKWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 05:22:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:44216 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264229AbUAZKWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 05:22:24 -0500
Date: Mon, 26 Jan 2004 11:20:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, maxk@qualcomm.com
Subject: Bluetooth USB oopses on unplug (2.6.1)
Message-ID: <20040126102041.GA1112@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In 2.6.1, bluetooth-over-usb (hci_usb) works very well... As long as I
do not unplug it. When I do, it oopses. Is there newer version of
bluetooth that I should try?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
