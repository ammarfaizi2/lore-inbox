Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272483AbTGZNTb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 09:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272484AbTGZNTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 09:19:31 -0400
Received: from web14206.mail.yahoo.com ([216.136.173.70]:26989 "HELO
	web14206.mail.yahoo.com") by vger.kernel.org with SMTP
	id S272483AbTGZNTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 09:19:30 -0400
Message-ID: <20030726133441.31321.qmail@web14206.mail.yahoo.com>
Date: Sat, 26 Jul 2003 06:34:41 -0700 (PDT)
From: Manjunathan Padua Yellappan <manjunathan_py@yahoo.com>
Subject: Re: Loading of modules fails while using  kernel 2.6.0-test1
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1059226184.637.0.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
wrote:
> On Sat, 2003-07-26 at 15:19, Manjunathan Padua
> Yellappan wrote:
> >  Now I am encountering another problem, after
> > successful compilation/installation/booting of
> kernel
> > 2.6.0-test1 , the modules are not loading at all ,
> > even after installing the latest version of
> > "module-init-tools-0.9.13-pre" .
> 
> What's the output of running the following command
> as root:
> 
> cat /proc/sys/kernel/modprobe
 
The output of the above command is

[root@localhost root]# cat /proc/sys/kernel/modprobe
/sbin/modprobe
[root@localhost root]#


Thanks,
Manjunathan PY






__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
