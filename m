Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVBEKOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVBEKOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266424AbVBEKOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:14:46 -0500
Received: from [211.58.254.17] ([211.58.254.17]:63632 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S266405AbVBEKOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:14:39 -0500
Message-ID: <42049C8B.3090103@home-tj.org>
Date: Sat, 05 Feb 2005 19:14:35 +0900
From: Tejun Heo <tj@home-tj.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] ide: driver updates (phase 2)
References: <20050205021502.GA17767@htj.dyndns.org> <42049786.2060505@home-tj.org>
In-Reply-To: <42049786.2060505@home-tj.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> 
>  Oops, I accidentally put ", ," in the To: line of all the mails which 
> contain patches, and they don't show up on the lkml.  I'll post the 
> patches again.
> 
>  Bartlomiej, if you got the first set of patches, please ignore them. 
> The contents are identical, so if you've already reviewed them, you 
> don't have to verify the new set.  I'm really sorry.  As I've been 
> making quite a few mistakes during mailing patches manually, I've 
> written a script to do it, but I still manage to make mistakes. :-(
> 

  I resent the patches and the same thing happened.  I digged the 
problem and found out that my script was faulty.  The reason was that 
the mail program didn't handle commas appropriately in to-addr list. 
Bartlomiej, I sincerely apologize for polluting your mailbox yet again. 
  Please forgive me, it won't happen again (really!). :-)

  I'll repost the patches in another thread.  Sorry again about the mess.

-- 
tejun

