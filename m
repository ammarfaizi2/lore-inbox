Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272652AbTG1CQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272651AbTG1CQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:16:14 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:62143 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S272643AbTG1COi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 22:14:38 -0400
Date: Sun, 27 Jul 2003 22:28:18 -0400
From: Yifang Dai <daiy@attbi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 - VFS: Cannot open root device "NULL" or sda1
Message-ID: <20030728022818.GA7221@yahoo.com>
References: <bg1df5$1c2$1@ask.hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bg1df5$1c2$1@ask.hswn.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 08:42:13PM +0000, Henrik Storner wrote:
> So I know 2.6.0-test1 works for me. But 2.6.0-test2 with the same
> configuration (just a "make oldconfig" in between) stops during boot
> with:
> 
> VFS: Cannot open root device "NULL" or sda1
> Please append a correct "root=" boot option
> Kernel panic: Unable to mount root fs on sda1
> 

I've got the same error, except my root device is /dev/hda3. It also
worked in 2.6.0-test1 :)

-- 
Yifang Dai		 |
eFax: (847)628-0255      |    Debian GNU/Linux
yifang_dai@yahoo.com     |    



