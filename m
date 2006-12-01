Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758071AbWLAC3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071AbWLAC3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 21:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758118AbWLAC3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 21:29:08 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:6056 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S1758071AbWLAC3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 21:29:05 -0500
Date: Fri, 1 Dec 2006 03:29:04 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>
Subject: Linux 2.6.19 VServer 2.1.x
Message-ID: <20061201022904.GP2826@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Containers <containers@lists.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ladies and Gentlemen!

here is the first Linux-VServer version (testing)
with support for the *spaces (uts, ipc and vfs)
introduced in 2.6.19 ...

http://vserver.13thfloor.at/Experimental/patch-2.6.19-vs2.1.x-t1.diff

it might not be as perfect as the kernel itself *G*
but it does work fine here, and with recent tools
most virtualization features work as expected

please if you do testing, report issues or comments
to the Linux-VServer mailing list or to me directly
(at least CC would be fine) and do not bother the
nice kernel folks ...

enjoy,
Herbert
