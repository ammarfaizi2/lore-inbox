Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVCYUxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVCYUxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCYUxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:53:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48100 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261795AbVCYUxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:53:46 -0500
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050325073846.A18596@flint.arm.linux.org.uk>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	 <a44ae5cd05032420122cd610bd@mail.gmail.com>
	 <20050324202215.663bd8a9.akpm@osdl.org>
	 <20050325073846.A18596@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 15:53:42 -0500
Message-Id: <1111784022.23430.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 07:38 +0000, Russell King wrote:
> Users need to be re-educated _not_ to use ksymoops.
> 

How about changing the fscking docs to not tell users to use it?

Seems like lots of stuff in Documentation/ is stuck in 2.4 land.  How
about purging it?  Incorrect docs are worse than nothing.

Lee

