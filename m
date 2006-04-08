Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWDHA4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWDHA4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 20:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWDHA43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 20:56:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:202 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751379AbWDHA43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 20:56:29 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.2.6
cc: linux-kernel@vger.kernel.org
Date: Fri, 07 Apr 2006 17:56:27 -0700
Message-ID: <7vek08j35w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.2.6 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.6.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.6-1.$arch.rpm	(RPM)

These fixes are my birthday present to git ;-).  I'll also do
the 1.3.0-rc3 tonight.

----------------------------------------------------------------

Changes since v1.2.5 are as follows:

Junio C Hamano:
      parse_date(): fix parsing 03/10/2006
      diff_flush(): leakfix.
      count-delta: match get_delta_hdr_size() changes.

Nicolas Pitre:
      check patch_delta bounds more carefully


