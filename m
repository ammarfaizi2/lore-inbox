Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVC0LLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVC0LLP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 06:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVC0LLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 06:11:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59349 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261571AbVC0LLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 06:11:07 -0500
Date: Sun, 27 Mar 2005 13:11:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <Pine.LNX.4.61.0503271259100.28439@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have come across a 16550A myself (in VMware) and so, tested it.
Linux reports it as a "16550A" while OpenBSD says it's a "NS16550A" --
output to this serial console (vmware: file) works fine, though.

My real box's serial is also a 16550A but havenot tested that- got no cable.


Jan Engelhardt
-- 
No TOFU for me, please.
