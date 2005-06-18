Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVFRS2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVFRS2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVFRSYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:24:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262181AbVFRSYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:24:10 -0400
Date: Sat, 18 Jun 2005 11:23:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-Id: <20050618112342.6a4d088f.akpm@osdl.org>
In-Reply-To: <200506181850.35381.adobriyan@gmail.com>
References: <20050617001330.294950ac.akpm@osdl.org>
	<20050617212338.GA16852@suse.de>
	<20050617143946.00f387d0.akpm@osdl.org>
	<200506181850.35381.adobriyan@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Saturday 18 June 2005 01:39, Andrew Morton wrote:
> > We should encourage people to use bugzilla as the initial
> > entry-point.  But if someone instead uses email as the first contact I'm
> > just a little bit reluctant to say "thanks, now go and try again".
> > 
> > Perhaps we could find some nice volunteer (hint) who could take the task of
> > transferring such reports into bugzilla.
> 
> Andrew, I'm going to file
> 
> 	Subject: 2.6.12: connection tracking broken?
> 	Subject: 2.6.12 cpu-freq conservative governor problem
> 	Subject: PROBLEM: libata + sata_sil on sil3112 dosen't work proper
> 	Subject: [2.6.12] x86-64 IO-APIC + timer doesn't work
> 
> around monday evening if there would be no activity.

Sounds good, thanks - let us know how it goes.

It'll need to be coordinated with the reporter in some way.  It may end up
too confusing.

> Do I understand correctly that the procedure is
> 
> 	1. Search for duplicates
> 	2. Choose category
> 	3. Add "From: Joe Reporter <>" at the beginning, copy-paste email.
> 	4. Add Joe and relevant lists to CC.
> 	5. Profi^WCommit
> 
> and bugzilla won't shoot unsuspecting guys afterwards?

I think so.  I've never entered a bug ;)
