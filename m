Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWJBIRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWJBIRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 04:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWJBIRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 04:17:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35529 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750835AbWJBIRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 04:17:20 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.2.3
cc: linux-kernel@vger.kernel.org
Date: Mon, 02 Oct 2006 01:17:19 -0700
Message-ID: <7vu02nw2r4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.2.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.3-1.$arch.rpm	(RPM)

Sorry to be doing two maintenance releases in rapid succession,
but git-mv breakage causes random tree corruption and is rather
serious.

----------------------------------------------------------------

Changes since v1.4.2.2 are as follows:

Junio C Hamano:
      git-mv: invalidate the removed path properly in cache-tree
      git-push: .git/remotes/ file does not require SP after colon


