Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTEKPiy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 11:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTEKPiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 11:38:54 -0400
Received: from main.gmane.org ([80.91.224.249]:27867 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261707AbTEKPiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 11:38:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Make kernel.bkbits.net public via web? [was Re: kernel.bkbits.net
 and BK->CVS gateway]
Date: Sun, 11 May 2003 11:45:51 -0400
Message-ID: <3EBE702F.3020709@myrealbox.com>
References: <20030510140455.GA23475@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.74.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Try #2, first one didn't seem make it.
> 
> ----- Forwarded message from Linux Kernel Mailing List <linux-kernel@vger.kernel.org> -----
> 
> Date: Fri, 9 May 2003 19:46:13 -0700
> From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: hpa@transmeta.com, davem@redhat.com
> Subject: kernel.bkbits.net and BK->CVS gateway
> 
> We replaced the bad drive and are restoring home directories.
> Once we have the restore done, we'll turn on people's accounts again.
> We are shutting off nightly backups for a few days so that we have 
> the backups to cherry pick any missing config files, etc.

[SNIP]

Larry,

I was wondering if you would considier putting a bkbits web frontend on 
kernel.bkbits.net.  I can think of a few cases where it might come in 
handy.  For example, one of the devs is too busy (understandably) to 
roll a patch at a given point in time and states in response to a bug 
report that (s)he'll get linus to pull the fixes later on.  In this 
case, people who like to live dangerously and don't want to wait might 
take it upon themselves to surf over to kernel.bkbits.net and download 
the ChangeSet rather than cloning an *entire* tree just to get it.  I 
suppose this would also serve as a means for people who do not (or 
cannot) use bitkeeper to get said ChangeSet.

Cheers,
Nicholas


