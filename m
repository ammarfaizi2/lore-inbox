Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVEOUVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVEOUVD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEOUVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:21:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:51863 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261225AbVEOUU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:20:56 -0400
Message-ID: <4287AF22.8090300@pobox.com>
Date: Sun, 15 May 2005 16:20:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Baudis <pasky@ucw.cz>
CC: James Ketrenos <jketreno@linux.intel.com>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: git repository for net drivers available
References: <42841A3F.7020909@pobox.com> <4284C54E.3060907@linux.intel.com> <4284C7DA.1020707@pobox.com> <20050515200514.GA31414@pasky.ji.cz>
In-Reply-To: <20050515200514.GA31414@pasky.ji.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Fri, May 13, 2005 at 05:29:30PM CEST, I got a letter
> where Jeff Garzik <jgarzik@pobox.com> told me that...
> 
>>Looks like cogito is using $repo/heads/$branch, whereas my git repo is 
>>using $repo/branches/$branch.
> 
> 
> Would it be a big problem to use refs/heads/$branch? That's the
> currently commonly agreed convention about location for storing branch
> heads, not just some weird Cogito-specific invention. And it'd be very
> nice to have those locations consistent across git repositories.

Sure, that's doable.

I've pushed out this change to kernel.org.

	Jeff



