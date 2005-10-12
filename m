Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVJLHco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVJLHco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 03:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVJLHco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 03:32:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:35282 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751331AbVJLHco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 03:32:44 -0400
X-Authenticated: #4707809
Date: Wed, 12 Oct 2005 09:32:47 +0200
From: Fridtjof Busse <fbusse@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14-rc4] ipw2200 still filling up dmesg
Message-Id: <20051012093247.1b557945.fbusse@gmx.de>
X-Mailer: Sylpheed version 2.1.3 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm aware that this problem has been reported before, but I was hoping
this would get fixed before 2.6.14 is released. The bug in bugzilla
also has been ignored so far [1].
I can't see a single thing in dmesg besides
eth1 (WE) : Driver using old /proc/net/wireless support, please fix
driver !
This is really annoying, any hope for this getting fixed?
Please CC me, thanks.

[1] http://bugzilla.kernel.org/show_bug.cgi?id=5251

-- 
Fridtjof Busse
