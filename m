Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUKWWDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUKWWDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUKWWBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:01:47 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:49117 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261531AbUKWWBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:01:24 -0500
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two
	stage V2.]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com
In-Reply-To: <20041123215402.GE25926@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com>
	 <20041122103240.GA11323@hugang.soulinfo.com>
	 <20041122110247.GB1063@elf.ucw.cz> <200411221254.40732.rjw@sisk.pl>
	 <1101160249.7962.52.camel@desktop.cunninghams>
	 <20041123215402.GE25926@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101247050.5805.73.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 08:57:30 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-11-24 at 08:54, Pavel Machek wrote:
> Hi!
> 
> > You guys are slowly developing swsusp into suspend2 :>. Just in case
> > you're wondering, I haven't given up on merging; I've just been seeking
> > to get it as bug free as possible, do clean ups and documentation and so
> > on before getting stuck in to submitting it.
> 
> :-) Well, see how he is producing relatively small patches ;-).

Mmm. But I don't want to try to patch swsusp into suspend2. I just want
to merge - there are too many big differences between swsusp and
suspend2 for that (it's been redesigned from the ground up).

I'm thinking that rather than trying to get everything nice and tidy and
perfect before I submit it, I should just put it up for review now,
acknowledging that I still need to do more work on the docs and so on,
and see how I go. Sound feasible?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

