Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTKNARG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 19:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTKNARG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 19:17:06 -0500
Received: from dsl093-039-041.pdx1.dsl.speakeasy.net ([66.93.39.41]:19924 "EHLO
	raven.beattie-home.net") by vger.kernel.org with ESMTP
	id S261606AbTKNARE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 19:17:04 -0500
Subject: serverworks usb under 2.4.22
From: Brian Beattie <beattie@beattie-home.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1068769021.884.4.camel@kokopelli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 13 Nov 2003 19:17:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a system with a Super Micro P3 dual processor board.  This
board uses the Serverworks chipset and the 2.4.22 kernel is unable to
allocate an IRQ when initializing the USB (usb-ohic) interface.  This
board works fine under 2.4.20 and 2.4.21.

Any ideas?
-- 
Brian Beattie            | Experienced kernel hacker/embedded systems
beattie@beattie-home.net | programmer, direct or contract, short or
www.beattie-home.net     | long term, available immediately.

"Honor isn't about making the right choices.
It's about dealing with the consequences." -- Midori Koto


