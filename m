Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTDVHnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 03:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTDVHnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 03:43:12 -0400
Received: from iits0165.inlink.com ([209.135.140.65]:35774 "EHLO
	vs365.rosehosting.com") by vger.kernel.org with ESMTP
	id S262974AbTDVHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 03:43:11 -0400
Date: Tue, 22 Apr 2003 03:48:21 -0400
From: Michael B Allen <mba2000@ioplex.com>
To: linux-kernel@vger.kernel.org
Subject: What's the deal McNeil? Bad interactive behavior in X w/ RH's
 2.4.18
Message-Id: <20030422034821.6a57acc0.mba2000@ioplex.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running Red Hat 7.3 with their stock 2.4.18-3 kernel on an IBM
T30. Once every few hours X locks up for 5-10 seconds while the disk
grinds. If I type in an Xterm the characters are not echoed until the
disk grinding stops. Then they all come out in a bunch and life is back
to normal.

I asked about this on kernelnewbies but the only response was something
regarding some kind of change to the 'elevator code' but they didn't
know of a solution.

I would like very much for this behavior to go away as it is extremely
annoying. If there is a patch please let me know where I can get it.

Thanks,
Mike

-- 
A  program should be written to model the concepts of the task it
performs rather than the physical world or a process because this
maximizes  the  potential  for it to be applied to tasks that are
conceptually  similar and, more important, to tasks that have not
yet been conceived. 
