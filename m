Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUG1UAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUG1UAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUG1UAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:00:06 -0400
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:29961
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S261685AbUG1UAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:00:03 -0400
Date: Wed, 28 Jul 2004 21:59:57 +0200
From: Santiago Garcia Mantinan <bridge@manty.net>
To: bridge@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Assertion failed in bridge code on 2.4.27-rc3
Message-ID: <20040728195957.GA2621@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was testing 2.4.27-rc3 to see if the IDE fixes had fixed a problem I'm
suffering with a 200MB old HD, and instead of finding that fixed, I found
the kernel shouting this:
RTNL: assertion failed at br_ioctl.c(244)

This message is shown aproximately since the bridge is bringed up and till
it starts forwarding.

I don't know what other info to provide, this bridge interface right now has
just one card added to it, the machine is a pentium 133.

If you feel that any other info or any testing may be needed don't hesitate
to ask.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
