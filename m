Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWEDIBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWEDIBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 04:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbWEDIBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 04:01:30 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:13748 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751435AbWEDIB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 04:01:29 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.3.2
cc: linux-kernel@vger.kernel.org
Date: Thu, 04 May 2006 01:01:28 -0700
Message-ID: <7v4q066wx3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.3.2 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.3.2.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.3.2-1.$arch.rpm	(RPM)

Mostly documentation and usability fixes, with no exciting new
features, as the maintenance series ought to be.

----------------------------------------------------------------

Changes since v1.3.1 are as follows:

Huw Davies:
      git-format-patch: Use rfc2822 compliant date.

Jon Loeliger:
      Alphabetize the glossary.
      Added definitions for a few words:
      Add a few more words to the glossary.

Junio C Hamano:
      rebase: typofix.
      commit-tree.c: check_valid() microoptimization.
      verify-pack: check integrity in a saner order.
      git-am --resolved: more usable error message.

Linus Torvalds:
      Fix filename verification when in a subdirectory

Martin Langhoff:
      git-send-email: fix version string to be valid perl

Matthias Kestenholz:
      annotate: fix warning about uninitialized scalar
      annotate: display usage information if no filename was given
      fix various typos in documentation

Robert Shearman:
      give "what now" hint to users upon git-am failure.

Sean Estabrooks:
      Update the git-branch man page to include the "-r" option,
      Fix up remaining man pages that use asciidoc "callouts".
      Properly render asciidoc "callouts" in git man pages.
      Fix trivial typo in git-log man page.


