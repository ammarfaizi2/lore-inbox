Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbULBVTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbULBVTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbULBVMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:12:10 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43444 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261772AbULBVIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:08:19 -0500
Subject: Re: Suspend 2 merge: 50/51: Device mapper support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Alasdair G Kergon <agk@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041202204042.GD24233@agk.surrey.redhat.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300802.5805.398.camel@desktop.cunninghams>
	 <20041125235829.GJ2909@elf.ucw.cz>
	 <1101427667.27250.175.camel@desktop.cunninghams>
	 <20041202204042.GD24233@agk.surrey.redhat.com>
Content-Type: text/plain
Message-Id: <1102021461.13302.40.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 03 Dec 2004 08:04:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-12-03 at 07:40, Alasdair G Kergon wrote:
> On Fri, Nov 26, 2004 at 11:07:47AM +1100, Nigel Cunningham wrote:
> > On Fri, 2004-11-26 at 10:58, Pavel Machek wrote:
> > > This needs to go through dm people....
> > Yes. I'll look for contact details.
>  
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
> 
> Exposing dm internals like struct io to the rest of the kernel
> is unlikely to be the right way to do things.

It's not internals that need to be exposed. Rather, it's the amount of
memory needed to work during suspending.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

