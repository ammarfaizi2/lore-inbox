Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWIAEIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWIAEIg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWIAEIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:08:36 -0400
Received: from 1wt.eu ([62.212.114.60]:51729 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751092AbWIAEIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:08:36 -0400
Date: Fri, 1 Sep 2006 05:44:02 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.33.3
Message-ID: <20060901034402.GA28317@1wt.eu>
References: <20060831202636.GA26765@hera.kernel.org> <dh3ff2lapcu7267j23cjvn9p5v1pvusr6u@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dh3ff2lapcu7267j23cjvn9p5v1pvusr6u@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:37:01AM +1000, Grant Coady wrote:
> On Thu, 31 Aug 2006 20:26:36 +0000, Willy Tarreau <wtarreau@hera.kernel.org> wrote:
> 
> >Hi !
> >
> >This is the third version of 2.4.33-stable. The fix for the UDF deadlock
> >mentionned in previous announce has been merged, as well as the second
> >part of the SCTP fix. Other patches fix rather minor but annoying bugs.
> 
> stable
> + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
> | kernel version  |deltree|hal    |niner  |peetoo |pooh   |sempro |silly  |tosh   |
> + - - - - - - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - +
> | 2.4.33.3 [2,3]  |   Y   |   Y   |   Y   |   Y   |       |   Y   |   Y   |   Y   |
> ...
> [1] unofficial rename of 2.4.33.1 for testing under slackware, to be resolved...
> [2] requires upgrade to glibc-solibs-2.3.5-i486-6_slack10.2.tgz for slack-10.2
> [3] deltree still uses rename hack [1] until upgrade to slackware-11.0
> 
>   -- <http://bugsplatter.mine.nu/test/linux-2.4/>
> 
> Works for me :o)
> 
> Grant.

Cool, thanks for your tests, Grant !
Willy

