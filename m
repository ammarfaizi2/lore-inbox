Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVDVH4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVDVH4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVDVH4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:56:19 -0400
Received: from hera.kernel.org ([209.128.68.125]:42129 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261628AbVDVH4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:56:08 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Linux 2.6.12-rc3
Date: Fri, 22 Apr 2005 07:55:50 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d4aam6$dl1$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1114156550 13986 127.0.0.1 (22 Apr 2005 07:55:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 22 Apr 2005 07:55:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050421112022.GB2160@elf.ucw.cz>
By author:    Pavel Machek <pavel@suse.cz>
In newsgroup: linux.dev.kernel
> 
> You should put this into .git/remotes
> 
> linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 

Make that
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Right now they're the same thing, but it's not guaranteed to stay that way.

      -hpa
