Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163272AbWLGUQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163272AbWLGUQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163276AbWLGUQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:16:28 -0500
Received: from lug-owl.de ([195.71.106.12]:33432 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163272AbWLGUQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:16:28 -0500
Date: Thu, 7 Dec 2006 21:16:27 +0100
From: Michael Westermann <michael@dvmwest.de>
To: linux-kernel@vger.kernel.org
Subject: DTR/DSR handshake in kernelspace third traying 
Message-ID: <20061207201626.GA10920@dvmwest.dvmwest.de>
Mail-Followup-To: Michael Westermann <michael@dvmwest.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've send 2 patches for a DTS/DSR handshaking to the list

http://lkml.org/lkml/2004/5/7/76  and long long time ago 1998

My problem are manufacturers the make printers with
DTR/DSR Handschaking. POS Printers are very sensible for
a buffer overrun!

For on or two printers, we can wire a adapter, for 10000...30000
printers is a software option the better way.

I've write a patch for 2.2 and published it, 
I've write a patch for 2.4 and published it, but i've see there is no

DTR/DSR Handshaking in the kernel 2.6.

I'm a litte bit  frusted. Are a few  thousands pos-systems not
enough for upgrading the standard kernel sources?

Have I a really chance to commit a patch for kernel 2.6.

What is the best way to handle this problem.

Thanks for comments ;-)

Michael Westermann
