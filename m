Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWFJWjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWFJWjT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWFJWjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:39:19 -0400
Received: from buick.jordet.net ([217.8.143.72]:39042 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S1161048AbWFJWjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:39:18 -0400
Subject: APIC error on CPU1: 00(40)
From: Stian Jordet <liste@jordet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 11 Jun 2006 00:38:43 +0200
Message-Id: <1149979123.10302.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have very recently acquired a Intel SC450NX server. It's a Quad
Pentium III Xeon 550 mhz. With the Debian Sarge 2.6.8 kernel, I got
quite some "APIC error on CPU1: 00(40)" with some load. After upgrading
to a self-made 2.6.16.19, the messages disappeared. I thought. I just
got them back (with heavy load). I have yet to see them with a 2.4.27
kernel, with will check that more later.

Anyway, I've searched google, and this seems to indicate bad hardware.
But the server is rock solid here, and the previous owner claims he
never had any problems with it. If it's indeed bad hardware, could it be
a cpu? The RAID-controller? Memory? Or the motherboard? The system is
very well cooled, btw. Or could this be a fault with all the SC450NX
motherboards? Haven't really read about anyone using these with Linux
still (but of course, that could be because noone has any problems with
them :)

And second, It's always like this:

APIC error on CPU1: 00(40)
APIC error on CPU1: 40(40)
APIC error on CPU1: 40(40)

one 00(40) and several 40(40). What does these numbers mean?

Hope someone can help me.

Best regards,
Stian

