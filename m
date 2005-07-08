Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVGHJbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVGHJbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVGHJbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:31:25 -0400
Received: from math.ut.ee ([193.40.36.2]:65463 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262399AbVGHJac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:30:32 -0400
Date: Fri, 8 Jul 2005 12:30:26 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: GIT tree broken?
Message-ID: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to sync with 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
with cogito cg-update (cogito 0.11.3+20050610-1 Debian package) and it 
fails with the following error:

Applying changes...
error: cannot map sha1 file 043d051615aa5da09a7e44f1edbb69798458e067
error: Could not read 043d051615aa5da09a7e44f1edbb69798458e067
cg-merge: unable to automatically determine merge base

-- 
Meelis Roos (mroos@linux.ee)
