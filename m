Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTD2WEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTD2WEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:04:31 -0400
Received: from zeke.inet.com ([199.171.211.198]:35830 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S261177AbTD2WEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:04:30 -0400
Message-ID: <3EAEF9BE.5060805@inet.com>
Date: Tue, 29 Apr 2003 17:16:30 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pawan Deepika <pawan_deepika@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 'tainting kernel' problem in linux-2.4.18
References: <20030429215318.27252.qmail@web41608.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawan Deepika wrote:
> Hi,
> 
>  I am trying LKM with linux-2.4.18. I have a problem
> here. When I load the module using 'insmod' command,
> module gets loaded but I get following error
> 
> ------------------------------------------------------
> /sbin/insmod ./hello.o
> Warning: loading ./hello.o will taint the kernel: no
> license
>   See http://www.tux.org/lkml/#export-tainted for
> information about tainted modules
> Module hello loaded, with warnings
> ----------------------------------------------------
> 
> Can anyone tell me why I am getting this problem and
> what is the impact of this error while module is
> running in kernel. 

Read the url provided in the error message.

If that is not enough, perhaps this one will help: 
http://lwn.net/2001/0906/kernel.php3

You may want to try kernel-newbies instead since this would be more 
on-topic there.

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

