Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270084AbUJTG7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270084AbUJTG7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270108AbUJTGxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 02:53:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:42141 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270128AbUJTGto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 02:49:44 -0400
Subject: Versioning of tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098254970.3223.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 16:49:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

After you tag a "release" tree in bk, could you bump the version number
right away, with eventually some junk in EXTRAVERSION like "-devel" ?

It's quite painful to have a module dir name clash between the "clean"
final tree and whatever dev stuff we are testing out of bk ... it's fine
once you go to -rc1, but in the meantime, it's really annoying.

Cheers,
Ben.


