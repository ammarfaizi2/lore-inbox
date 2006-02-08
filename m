Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbWBHEb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbWBHEb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWBHEb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:31:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965198AbWBHEbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:31:25 -0500
Date: Tue, 7 Feb 2006 20:31:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET]  misc annotations and fixes
In-Reply-To: <E1F6fpy-0006B8-Uf@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0602072029370.2458@g5.osdl.org>
References: <E1F6fpy-0006B8-Uf@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Feb 2006, Al Viro wrote:
>
> 	Assorted trivial stuff all over the place.  Please, pull from
> for-linus branch in git.kernel.org/pub/scm/linux/kernel/git/viro/bird.git/
> Hopefully I haven't fscked it up - first attempt at passing stuff that way...

Looks fine to me. Pulled.

> 	Individual patches will go to l-k (hopefully with all relevant Cc)
> in a few minutes.

In the future, if you decide to continue with a git merge, you don't even 
need to send patches. I prefer just the overview, the "please pull" and 
then for information I prefer the the diffstat and the log messages.

Thanks,

		Linus
