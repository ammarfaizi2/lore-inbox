Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWGRVFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWGRVFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWGRVFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:05:08 -0400
Received: from main.gmane.org ([80.91.229.2]:60312 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750708AbWGRVFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:05:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Linux 2.6.16.25
Date: Tue, 18 Jul 2006 17:07:53 -0400
Message-ID: <e9jid5$fak$1@sea.gmane.org>
References: <20060715025906.GA11167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mail.tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
In-Reply-To: <20060715025906.GA11167@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> We (the -stable team) are announcing the release of the 2.6.16.25 kernel.
> 
> I'll also be replying to this message with a copy of the patch between
> 2.6.16.24 and 2.6.16.25, as it is small enough to do so.

Why does the patch make it to linux-kernel-announce and the nice 
announcement, like this one, not? The short patch description is far 
more useful, since if it's to something I don't use I don't need to 
apply or examine it.
> 
> The updated 2.6.16.y git tree can be found at:
>  	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> and can be browsed at the normal kernel.org git web browser:
> 	www.kernel.org/git/
> 
> thanks,
> 
> greg k-h
> 
> --------
> 
> 
>  Makefile       |    2 +-
>  fs/proc/base.c |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> Summary of changes from v2.6.16.24 to v2.6.16.23
> ================================================
> 
> Greg Kroah-Hartman:
>       Linux 2.6.16.25
> 
> Linus Torvalds:
>       Fix nasty /proc vulnerability (CVE-2006-3626)
> 


-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

