Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUIEMO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUIEMO2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUIEMO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:14:28 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:11920 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266531AbUIEMOZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:14:25 -0400
Subject: Scheduler experiences
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 05 Sep 2004 14:14:24 +0200
Message-Id: <1094386464.18114.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, i wonder which scheduler you people have the best experiences with,
staircase or nicksched?

personally i were using nicksched for a long time, but then i tried
staircase, and i like it overall more,

with nicksched its like, 1 process gets good prioity, so that if tvtime
is running, it runs perfect, but moving windows and stuff will be not so
fluid.
with staircase, the overall performance is not as fast, but
interactivity is really good, like tvtime runs fine, moving windows are
fast as lightening, setiathome can also run perfect.


-- 
Kasper Sandberg <lkml@metanurb.dk>

