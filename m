Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbWCID3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbWCID3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWCID3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:29:33 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:10249 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1161007AbWCID3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:29:32 -0500
Date: Thu, 9 Mar 2006 03:29:21 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Kernel panic on PC with broken hard drive, after DMA errors
Message-ID: <20060309032920.GD10330@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My laptop hard drive recently died (or is in the process of dying).
HP wanted me to do some more tests before sending me a replacement, so
I tried booting Linux again today.  I got lots of DMA errors, which
was really to be expected, but then I got a kernel panic.  While I'd
not blame the kernel when a panic occurs with broken RAM or CPU, I'm
sure sure the kernel should panic just because of a broken IDE drive.

I posted a picture of the panic at http://cyrius.com/tmp/ide_panic.jpg
Is this something that can be fixed or is my hardware really so broken
that the kernel cannot deal with it?
-- 
Martin Michlmayr
http://www.cyrius.com/
