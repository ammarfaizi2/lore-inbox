Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWF2Gk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWF2Gk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 02:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWF2Gk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 02:40:57 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24971 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932672AbWF2Gk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 02:40:56 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.1-rc2
cc: linux-kernel@vger.kernel.org
Date: Wed, 28 Jun 2006 23:40:55 -0700
Message-ID: <7vwtb0tqfc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tip of "master" branch has been tagged as GIT 1.4.1-rc2.
Many fixes since v1.4.1-rc1 was done, but most notable are:

 - git-cvsimport to manage multiple branches are (hopefully)
   fixed now (Martin and Johannes).

 - git-rebase learned how to use 3-way merge backends by
   "git-rebase --merge" (Eric Wong).

 - git-svn updates (Eric Wong).

 - "git-commit -m" breakage was fixed (me).

Hopefully we can merge the format-patch fixes from Johannes,
which is still cooking in "next", and do the real 1.4.1 release
this weekend.

