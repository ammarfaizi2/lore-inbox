Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWIXUeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWIXUeR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWIXUeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:34:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18062 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932072AbWIXUeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:34:16 -0400
Date: Sun, 24 Sep 2006 22:34:15 +0200
From: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Cogito-0.17.4
Message-ID: <20060924203415.GZ20017@pasky.or.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  cogito-0.17.4 was just released - bugfixes release on the latest
stable line of the Cogito user-friendly Git user interface.

  Just a few tiny bugfixes.  So, what's new?

  * Make cg-commit -p imply -e
  * Fix cg-commit -M with relative path called from a subdirectory
  * Be way more paranoid when failing to apply patches w/ cg-commit -p
  * Do not use type -P (bash31ism)
  * Make documentation build with `make` not being GNU make
  * When fetching, autofollow lightweight tags as well

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
