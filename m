Return-Path: <linux-kernel-owner+w=401wt.eu-S1030475AbXAHDaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbXAHDaw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 22:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbXAHDaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 22:30:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32861 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030470AbXAHDav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 22:30:51 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.4.4.4
cc: linux-kernel@vger.kernel.org
Date: Sun, 07 Jan 2007 19:30:50 -0800
Message-ID: <7v7ivyyz2t.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.4.4.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.4.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.4.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.4.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.4.4-1.$arch.rpm	(RPM)

This is to push out a handful bugfixes since 1.4.4.3.

On the 'master' development front, the stabilization for v1.5.0
will start soonish.

----------------------------------------------------------------

Changes since v1.4.4.3 are as follows:

Johannes Schindelin (1):
      diff --check: fix off by one error

Junio C Hamano (3):
      spurious .sp in manpages
      Fix infinite loop when deleting multiple packed refs.
      pack-check.c::verify_packfile(): don't run SHA-1 update on huge data



