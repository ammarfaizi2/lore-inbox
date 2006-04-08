Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWDHBFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWDHBFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWDHBFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:05:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18644 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751380AbWDHBFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:05:31 -0400
Date: Sat, 8 Apr 2006 03:06:26 +0200
From: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Cogito-0.17.2
Message-ID: <20060408010626.GR27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  to join the series of git-related announcements, Cogito-0.17.2, the next
maintenance release on the current stable (v0.17) branch of Cogito, the
human-friendly version control system on top of Git, is available now.

  There are only very few changes, it looks that we are pretty stable:

Chris Wright:
      cogito spec BuildRequires update

Dennis Stosberg:
      cogito: Push tags over http

Petr Baudis:
      Improved cg-version output (use cg-object-id -d)
      cg-patch -c: Stop also at ^diff --git when slurping the commit message
      Fixed embarassing cg-admin-rewritehist bug
      Make cg-add/rm warnings less confusing: s/files/items/
      cogito-0.17.2


P.S.: Visit us at #git @ FreeNode!

  Happy hacking,

-- 
				Petr "Stable Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
