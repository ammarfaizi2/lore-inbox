Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTJTQHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJTQHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:07:52 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:5556 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262649AbTJTQHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:07:50 -0400
Date: Mon, 20 Oct 2003 12:01:52 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: bkcvs2svn rebuilt
Message-ID: <20031020160152.GM866@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a few people pointed out an inconsistency in the bksvn gateway, I
rebuilt the 2.4 and 2.5/2.6 repo's. Anyone with those trees checked out
will need to kill them and do a fresh checkout. If you have changes
local in your repo, you can still do a diff to bring them over to the
new checkout, since diff uses local copies, and doesn't contact the
remote repo.


Ben

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
