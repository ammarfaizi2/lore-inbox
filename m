Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbTGORV2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbTGORV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:21:28 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:3262 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S269107AbTGORVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:21:20 -0400
Date: Tue, 15 Jul 2003 13:36:25 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: SVN linux-2.6 repo
Message-ID: <20030715173625.GR20685@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've made a symlink from linux-2.6 to the linux-2.5 repo for the SVN
checkouts. I am assuming that the 2.5 tree will simply be renamed to
2.6, but I haven't heard back from Larry about that.

If you want, you can do:

svn switch --relocate svn://svn.kernel.org/linux-2.5 \
	svn://svn.kernel.org/linux-2.6

To change to the new URL for an existing checkout, or checkout using the
new URL of svn://svn.kernel.org/linux-2.6/trunk.



-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
