Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbTFNB22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 21:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265598AbTFNB22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 21:28:28 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:16914 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265597AbTFNB2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 21:28:25 -0400
Date: Fri, 13 Jun 2003 20:42:12 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: mga dualhead console + gpm = instant reboot
Message-ID: <20030614014212.GC1010@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I run the mga dualhead console.  It works ok for the most part (some
strange behavior on the second head happens that can be noticed in e.g.
lynx when the cursor is blinking).  However, if I move the gpm mouse on
the first head, switch to a console on the second head, move gpm mouse
again, then switch back to a console on the first head, moving the mouse
thereafter results in an instant reboot of the system.

Since there does not appear to be any kernel panic or oops, I am at a
loss how to track the problem down.  Any ideas?

Thanks,
-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
