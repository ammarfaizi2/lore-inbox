Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265557AbUBBCAz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 21:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbUBBCAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 21:00:54 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:2792 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S265557AbUBBCAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 21:00:54 -0500
Date: Sun, 1 Feb 2004 21:00:53 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6 EXTRAVERSION is bad for -rcX-bkY's
Message-ID: <20040202020053.GB21554@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

E.g.

EXTRAVERSION for 2.6.2-rc3-bk1 is "-bk1"; it should be "-rc3-bk1" no?

http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fsnapshots%2Fpatch-2.6.2-rc3-bk1.bz2;z=1

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

