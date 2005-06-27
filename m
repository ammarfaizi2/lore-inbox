Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVF0OvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVF0OvV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVF0Os7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:48:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:47568 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262122AbVF0MoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:44:10 -0400
Message-ID: <42BFF496.3040105@pobox.com>
Date: Mon, 27 Jun 2005 08:44:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x more net driver updates
References: <42BFEF86.8090000@pobox.com>
In-Reply-To: <42BFEF86.8090000@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Please pull from the 'upstream' branch of
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> 
> to obtain the various changes described in the attachment.

Or, if you wanted to be experimental, you could pull tag (not branch) 
'upstream-20050627-1' of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the same changes.

I think I will start using tags for my submissions, which will eliminate 
an old problem with BK:  After emailing a BitKeeper pull request to you, 
I had to stop pushing to the repo, until you pulled.  With tags, I can 
keep on committing changes, without worrying that you are pulling from a 
moving target.

	Jeff


