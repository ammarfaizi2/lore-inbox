Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbWIJD7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbWIJD7c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 23:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWIJD7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 23:59:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58787 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965204AbWIJD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 23:59:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: [PATCH 0/4] proc: Misc cleanups
Date: Sat, 09 Sep 2006 21:58:36 -0600
Message-ID: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches are in response to the review of the last round
of my proc patches, and they remove one small glitch I found.

It turned out to be easy to remove the trailing empty directory entry
so I remove it, etc. 

Eric

