Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVKNUTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVKNUTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVKNUTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:19:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:42438 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932084AbVKNUTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:19:17 -0500
Date: Mon, 14 Nov 2005 12:04:56 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [patch 00/12] USB patches for 2.6.15-rc1
Message-ID: <20051114200456.GA2319@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few USB patches against your latest git tree, they have all
been in the past few -mm releases just fine.  They fix some build bugs,
add some new device ids, and add a new simple usb-serial driver.

thanks,

greg k-h
