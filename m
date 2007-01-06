Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbXAFSqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXAFSqm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbXAFSqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:46:42 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:57243 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbXAFSql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:46:41 -0500
Date: Sat, 6 Jan 2007 13:46:39 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Guilt 0.16
Message-ID: <20070106184639.GC12543@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like [1] functionality and interface to git.  The one distinguishing
feature from other quilt-like porcelains, is the format of the patches
directory. _All_ the information is stored as plain text - a series file and
the patches (one per file). This easily lends itself to versioning the
patches using any number of of SCMs.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repository:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The code is licensed under GPLv2.

Of course, contributions and feedback are welcomed :)

Josef "Jeff" Sipek.

[1] http://www.selenic.com/mercurial/wiki/index.cgi/MqExtension
