Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263122AbVCEG0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbVCEG0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVCEGVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:21:25 -0500
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:61592 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263182AbVCEGQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:16:24 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Greg KH <greg@kroah.com>
Subject: Re: Linux 2.6.11.1
Date: Sat, 5 Mar 2005 01:16:10 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503050116.10577.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds great, I can be a QA resource for what machines I have. 

How do people get involved in QAing these releases? 

What other help?

Shawn.

> List:       linux-kernel
> Subject:    Linux 2.6.11.1
> From:       Greg KH <greg () kroah ! com>
> Date:       2005-03-04 17:53:02
> Message-ID: <20050304175302.GA29289 () kroah ! com>
> [Download message RAW]
> 
> For those of you who haven't waded through the huge "RFD: Kernel release
> numbering" thread on lkml to realize that we are now going to start
> putting out 2.6.x.y releases, here's the summary:
> 
>         A few of us $suckers will be trying to maintain a 2.6.x.y set of
>         releases that happen after 2.6.x is released.  It will contain
>         only a set of bugfixes and security fixes that meet a strict set
>         of guidelines, as defined by Linus at:
>                 http://article.gmane.org/gmane.linux.kernel/283396
> 
> Chris Wright and I are going to start working on doing this work, we
> will have a <SOME_ALIAS>@kernel.org to post these types of bug fixes to,
> and a set of people we bounce the patches off of to test for "smells
> good" validation.  We will also have a bk-commits type mailing list for
> those who want to watch the patches flow in, and a bk tree from which
> changsets can be pulled from.
> 
> Chris and I will be hashing all of the details out next Tuesday, and
> hopefully all the infrastructure will be in place soon.  When that
> happens, we will post the full details on how all of this is going to
> work.  In the meantime, feel free to CC: me and Chris on patches that
> everyone thinks should go into the 2.6.11.y releases.
> 
> But right now, Chris is on a plane, and we don't have the email alias
> set up, or the proper permissions set up on kernel.org to push changes
> into the v2.6 directory, but we have a few bugs that are needing to be
> fixed in the 2.6.11 release.  And since our mantra is, "release early
> and often", here's the first release.
