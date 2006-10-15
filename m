Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWJOQuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWJOQuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWJOQuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 12:50:24 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:51684 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1161033AbWJOQuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 12:50:24 -0400
X-Originating-Ip: 72.57.81.197
Date: Sun, 15 Oct 2006 12:49:20 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SPIN_LOCK_UNLOCKED, RW_LOCK_UNLOCKED deprecated or not?
Message-ID: <Pine.LNX.4.64.0610151246330.18156@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


from the file Documentation/spinlocks.txt:

  "UPDATE March 21 2005 Amit Gud <gud@eth.net>

  Macros SPIN_LOCK_UNLOCKED and RW_LOCK_UNLOCKED are deprecated and
  will be removed soon."

but it seems that there's still a whole lot of those
SPIN_LOCK_UNLOCKED macros being used.  so are they deprecated or not?
just curious.

rday
