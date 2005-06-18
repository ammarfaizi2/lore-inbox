Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVFRUFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVFRUFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 16:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVFRUFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 16:05:06 -0400
Received: from mail.dvmed.net ([216.237.124.58]:28307 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261468AbVFRUE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 16:04:59 -0400
Message-ID: <42B47E68.9020601@pobox.com>
Date: Sat, 18 Jun 2005 16:04:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
References: <42B456E2.8000500@pobox.com> <Pine.LNX.4.58.0506181047190.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506181105110.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506181112590.2268@ppc970.osdl.org> <42B469B6.2060502@pobox.com> <Pine.LNX.4.58.0506181146260.2268@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506181146260.2268@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, I ended up re-doing the merge by hand (ie I fetched all the other 
> parts, ignored your top entry, and just merged the previous one manually). 
> 
> I'm pushing out the result now, can you verify that the r8192.c file looks
> like you expected it to look? I think it should be the same thing you
> ended up with except for fixed parents, but...

Looks good here, thanks.

I re-did the merge locally, as a test, finalizing with 'git commit' 
rather than 'git-commit-tree ...' and the parent info came out correct. 
  FWIW.

	Jeff


