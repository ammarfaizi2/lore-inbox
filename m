Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTF1EoX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 00:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265072AbTF1EoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 00:44:23 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:59656 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265069AbTF1EoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 00:44:22 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.73-mm1 nbd: boot hang in add_disk at first call from nbd_init
Date: Sat, 28 Jun 2003 12:55:34 +0800
User-Agent: KMail/1.5.2
Cc: ldl@aros.net, linux-kernel@vger.kernel.org
References: <200306271943.13297.mflt1@micrologica.com.hk> <20030627194154.01a06c5d.akpm@digeo.com>
In-Reply-To: <20030627194154.01a06c5d.akpm@digeo.com>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306281255.36048.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 June 2003 10:41, Andrew Morton wrote:
> Michael Frank <mflt1@micrologica.com.hk> wrote:
> > Changes were recently made to the nbd.c in 2.5.73-mm1
>
> And tons more will be in -mm2, which I shall prepare right now.
> Please retest on that and if it still hangs, capture the output
> from pressing alt-sysrq-T.

Legacy free, no serial port. 

>

Sorry, -mm2 hang at booting kernel on 2 machines. 

Regards
Michael

-- 
Powered by linux-2.5.73, compiled with gcc-2.95-3 - not fancy but rock solid

My current linux related activities:
- Test script development and testing of swsusp
- Everyday usage of 2.5 kernel

More info on the 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt

