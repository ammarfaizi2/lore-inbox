Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbTCGENH>; Thu, 6 Mar 2003 23:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbTCGENH>; Thu, 6 Mar 2003 23:13:07 -0500
Received: from smtp.popsite.net ([216.126.128.19]:15746 "EHLO smtp.popsite.net")
	by vger.kernel.org with ESMTP id <S261341AbTCGENG>;
	Thu, 6 Mar 2003 23:13:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Posix Semaphore implementation
From: Marc D Bumble <marc_bumble@cpinternet.com>
Date: 06 Mar 2003 23:25:12 -0500
Message-ID: <m3r89jn6qf.fsf@cadence.glidepath.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the best approach for using semaphores which are shared across
multiple  processes under  Linux?  Are  SysV semaphores  the currently
accepted  best alternative,  or  is there  another preferred  approach
instead of sem_init()?

Thanks,

Marc

-- 

