Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWI3Gxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWI3Gxn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 02:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWI3Gxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 02:53:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:42434 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751076AbWI3Gxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 02:53:42 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.2.2
cc: linux-kernel@vger.kernel.org
Date: Fri, 29 Sep 2006 23:53:41 -0700
Message-ID: <7v8xk1j156.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.2.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.2.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.2.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.2.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.2.2-1.$arch.rpm	(RPM)

This is strictly a bugfix release.  While we will soon be in
stabilization slow-down for 1.4.3, one of the bugs this release
contains fixes for actually has bitten people who use the kernel
commits mailing list, so this is to push the fixes out early.

----------------------------------------------------------------

Changes since v1.4.2.1 are as follows:

Junio C Hamano:
      Fix git-am safety checks
      git-diff -B output fix.

Liu Yubao:
      Fix duplicate xmalloc in builtin-add


