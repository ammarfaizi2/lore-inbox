Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWBPG0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWBPG0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 01:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWBPG0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 01:26:03 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26337 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750955AbWBPG0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 01:26:01 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.2.1
cc: linux-kernel@vger.kernel.org
Date: Wed, 15 Feb 2006 22:25:59 -0800
Message-ID: <7vzmkrizuw.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.2.1 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.1.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.1-1.$arch.rpm	(RPM)


Nothing earth-shattering but cleanups and cleanups and cleanups.

All the interesting things are happening in "master" and "pu",
which will be a topic for a separate message.

----------------------------------------------------------------

Changes since v1.2.0 are as follows:

Fernando J. Pereda:
      Print an error if cloning a http repo and NO_CURL is set

Fredrik Kuivinen:
      s/SHELL/SHELL_PATH/ in Makefile

Josef Weidendorfer:
      More useful/hinting error messages in git-checkout

Junio C Hamano:
      Documentation: git-commit in 1.2.X series defaults to --include.
      Documentation: git-ls-files asciidocco.
      bisect: remove BISECT_NAMES after done.
      combine-diff: diff-files fix.
      combine-diff: diff-files fix (#2)
      checkout: fix dirty-file display.


