Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVCOAth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVCOAth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVCOAsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:48:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:22940 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262164AbVCOArl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:47:41 -0500
Subject: What's going on here ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 11:43:52 +1100
Message-Id: <1110847432.5863.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi just see that the whole stack of pmac SWSUSP patches went in, without
any notice nor CC nor anything from any of the PPC maintainers ! That is
a bit annoying don't you think ?

Paulus and I wrote most of those patches, granted, and they've been
hanging around for some time, but I had good reasons not to submit them
in their current state.

And regardless, I'm pretty pissed off by the fact that such invasive
changes to the architecture and the platform support were submitted and
merged without any notice nor ack from any of the arch or platform
maintainers (basically paulus and me).

Ben.


