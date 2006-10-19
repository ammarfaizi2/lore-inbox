Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945938AbWJSAx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945938AbWJSAx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945936AbWJSAx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:53:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13283 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1423210AbWJSAxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:53:25 -0400
Date: Thu, 19 Oct 2006 02:53:23 +0200
From: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Cogito-0.18.1
Message-ID: <20061019005323.GB20017@pasky.or.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I've released cogito-0.18.1, bringing few minor new features and
random bugfixes to the cogito-0.18 version. Nothing groundshattering.

* cg-switch -c as a shortcut for cg-switch -r HEAD - use it to create a new
  branch with less typing
* cg-patch -e to edit log message before autocommitting (useful esp. as
  cg-patch -m -e)
* Support for cg-version --lib-dir, --share-dir
* cg-admin-rewritehist now defines a map() function for filters' use,
  translating from old to new commit ids
* cg-commit -e now runs editor on /dev/tty even if input is not a tty
* Trivial documentation improvements
* Random details fixed

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
