Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263321AbVFYDdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbVFYDdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 23:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbVFYDdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 23:33:52 -0400
Received: from mail.dvmed.net ([216.237.124.58]:30150 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263313AbVFYDdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 23:33:44 -0400
Message-ID: <42BCD092.6050201@pobox.com>
Date: Fri, 24 Jun 2005 23:33:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050622224003.GA21298@redhat.com>
In-Reply-To: <20050622224003.GA21298@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
>  > 
>  > Things in git-land are moving at lightning speed, and usability has 
>  > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
>  > 
>  > 
>  > 
>  > 1) installing git
>  > 
>  > git requires bootstrapping, since you must have git installed in order 
>  > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
>  > have put together a bootstrap tarball of today's git repository.
>  > 
>  > Download tarball from:
>  > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
> 
> <blatant self-promotion>
> daily snapshots (refreshed once an hour) are available at:
> http://www.codemonkey.org.uk/projects/git-snapshots/git/
> </blatant self-promotion>

I was about to link to this, but a problem arose:  your snapshots don't 
include the .git/objects directory.

Also, a git-latest.tar.gz symlink would be nice.

	Jeff


