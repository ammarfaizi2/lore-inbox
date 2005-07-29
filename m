Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVG2TST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVG2TST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVG2TQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:16:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:32174 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262707AbVG2TPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:15:03 -0400
Date: Fri, 29 Jul 2005 12:12:55 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 00/29] fixes for 2.6.13-rc4
Message-ID: <20050729191255.GA5095@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a series of patches against 2.6.13-rc4 that fix a number of
different bugs in the USB, I2C, driver core, and PCI subsystems.  They
also add a few new device ids, and add one new USB host controller
driver (adding new drivers was ok at this time frame, right?)

thanks,

greg k-h
