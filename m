Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268359AbUIBOMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268359AbUIBOMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUIBOMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:12:34 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:50108 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268336AbUIBOJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:09:26 -0400
Message-ID: <105c793f0409020709459a1e05@mail.gmail.com>
Date: Thu, 2 Sep 2004 10:09:26 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Coolmax HD-211-COMBO with Prolific PL3507 chipset
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I recently purchased a USB2+Firewire 2.5" portable harddrive
enclosure. The enclosure is from Coolmax and is a HD-211-COMBO. The
chipset is a Firewire and USB2 all-in-one deal called PL3507 from
Prolific. I've read a bit about this chipset and few people (who are
talking, at least) seem to have much success with it. I am strongly
considering returning the enclosure for a refund.

I have been able to get it to be detected and work on just one machine
running Linux; an IBM xSeries 206 server running Fedora Core 2 (kernel
2.6.5). The device is rarely detected, but when it is, it seems to use
the EHCI driver and it works fine until you unplug it and try to plug
it back in. This behavior is not only limited to Linux, though. I have
found just one Windows machine so far that detects it fine even if it
is unplugged and plugged back in.

So, while I'm very likely going to make use of Newegg's 30-day
money-back guarantee, I thought I'd try to help the community out
however I can. Not everyone has the luxury of being able to return
their hardware for a refund. So if I can help someone who is
developing a driver by testing it, I'd like to do that.  If anyone has
any drivers that they are writing that might help to make this device
work on Linux, I would be happy to be a guinea pig for your project.

The desktop system I have access to is running kernel 2.4.18, so that
would likely not be of any help. However, I installed 2.6.8.1 on my
Gateway Solo 2500 laptop (to no avail), so I can help with that
kernel. The USB ports on that machine are v1.1 only. I, unfortunately,
have no systems with USB2 or Firewire that are running Linux.

Unfortunately, my skills do not permit me to be a driver designer.
What I can do (and what I'm offering to do) is to test drivers for
people who need things tested.

So, if anyone has a need for help testing drivers for the PL3507
chipset, let me know.

Thank you.

-Andy
ahaning@gmail.com
