Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVCCJM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVCCJM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 04:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCCJM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 04:12:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:45973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261695AbVCCJKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 04:10:05 -0500
Date: Thu, 3 Mar 2005 01:06:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: davem@davemloft.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303010631.36220fb9.akpm@osdl.org>
In-Reply-To: <42268F93.6060504@pobox.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<422674A4.9080209@pobox.com>
	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> The reasons -rcs are not as good as they could be is that they include 
>  more than just bug fixes.

I thought we'd been fairly good about that, actually.  The -rc1's always
come too early for me (I usually wait for all the bk merges to happen). 
But once we hit -rc2 people are good?  At least, I think I've only ever
seen one "ytf did you merge that now" email...


<hack, hack>

Here you go: http://www.zip.com.au/~akpm/linux/patches/stuff/khack.jpeg

That's number-of-lines-of-patch versus day, from the bk-commits list. 
There's definitely a pattern there ;)

(Raw data at
http://www.zip.com.au/~akpm/linux/patches/stuff/commits.data.gz for anyone
who is inclined to spend more that seven seconds with gnuplot...)

