Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTIFVWx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 17:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTIFVWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 17:22:53 -0400
Received: from web40414.mail.yahoo.com ([66.218.78.111]:42917 "HELO
	web40414.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261891AbTIFVWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 17:22:51 -0400
Message-ID: <20030906212250.64809.qmail@web40414.mail.yahoo.com>
Date: Sat, 6 Sep 2003 14:22:50 -0700 (PDT)
From: Joshua Weage <weage98@yahoo.com>
Subject: Re: NFS client problems in 2.4.18 to 2.4.20
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16218.5318.401323.630346@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't any clues in the kernel logs, except that the kernel does
report "nfs server not responding" and never comes back with "nfs
server OK".  I've enabled kernel debugging on all of the cluster nodes,
but the above message is all that I get in the logs.

I'll have to try out tcpdump the next time this happens.

Thanks,

Joshua Weage

> 
> Does 'dmesg' produce any clues as to what is going on?
> 
> How about tcpdump?
> 


=====


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
