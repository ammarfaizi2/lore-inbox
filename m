Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVBRI5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVBRI5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 03:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVBRI5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 03:57:00 -0500
Received: from ptr210-netcat ([66.230.167.210]:56006 "EHLO
	mail.globalproof.net") by vger.kernel.org with ESMTP
	id S261305AbVBRI45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 03:56:57 -0500
Date: Fri, 18 Feb 2005 10:56:53 +0200
From: nuclearcat <nuclearcat@nuclearcat.com>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: nuclearcat <nuclearcat@nuclearcat.com>
Organization: NUC
X-Priority: 3 (Normal)
Message-ID: <1567604259.20050218105653@nuclearcat.com>
To: linux-kernel@vger.kernel.org
Subject: pty_chars_in_buffer NULL pointer (kernel oops)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear, linux-kernel.

Is discussed at
http://kerneltrap.org/mailarchive/1/message/12508/thread
bug fixed in 2.4.x tree? Cause seems i have downloaded 2.4.29, and it
is not fixed (still my kernel on vpn server crashing almost at start),
i have grepped fast pre and bk patches, but didnt found any fixed
related to tty/pty.
Provided in thread patch from Linus working, but after night i have
checked server, and see load average jumped to 700.
Can anybody help in that? I am not kernel guru to provide a patch, but
seems by search in google it is actual problem for people, who own
poptop vpn servers, it is really causing serious instability for
servers.


-- 
With best regards,
GlobalProof Globax Division Manager,
Denys Fedoryshchenko
mailto:denys@globalproof.net

