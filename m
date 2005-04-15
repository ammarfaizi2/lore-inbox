Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVDOKhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVDOKhl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 06:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVDOKhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 06:37:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1492 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261800AbVDOKhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 06:37:33 -0400
Date: Fri, 15 Apr 2005 12:36:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi updates for 2.6.12-rc2
Message-ID: <20050415103646.GB1797@elf.ucw.cz>
References: <1113442034.4933.53.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113442034.4933.53.camel@mulgrave>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a small set of bugfixes for 2.6.12-rc2 ... you asked me to try
> git, so I did (I actually updated my bk backport script simply to export
> from a BK tree to a git tree).  For the time being, I plan to keep the
> scsi changes in BK, but I'll export them for you to try merging
> 
> The patch (against kernel-test.git) is here
> 
> rsync://www.parisc-linux.org/~jejb/scsi-rc-fixes-2.6.git

Can you du -s on it? Just curious. I started rsync on it, but because
it is not standard gzip files, it is difficult to see anything
interesting...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
