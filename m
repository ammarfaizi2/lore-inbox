Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUFFQQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUFFQQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUFFQQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:16:16 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:28134 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S263781AbUFFQQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:16:01 -0400
Date: Sun, 6 Jun 2004 10:18:27 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040606161827.GC28576@bounceswoosh.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Jeff Garzik <jgarzik@pobox.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <200406041438.44706.bzolnier@elka.pw.edu.pl> <20040604124704.GA1946@suse.de> <200406041534.48688.bzolnier@elka.pw.edu.pl> <20040604152347.GD1946@suse.de> <40C0B191.2040201@pobox.com> <20040605092447.GB13641@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040605092447.GB13641@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun  5 at 11:24, Jens Axboe wrote:
>I did suggest this a few years ago. The comment I received was that
>they didn't take suggestions from OS people, if I didn't have a drive
>implementation to go with the proposal they couldn't use it for
>anything. Which was interesting, since that seemed to suggest that t13
>had little steering in ata development, they mainly put into the ATA
>specs what drive manufacturers shoved at them. Of course this isn't 100%
>true, but it does explain a lot of things :-)

If it helps, I'm listening.

Suggestions/proposals for new features etc, if they're a good idea, I
can help push inside via our SATA/T13 reps.  Note that as per all
long-lived specs with multiple revisions, changing the behavior of an
existing feature to something incompatible is virtually never
feasable.

>Andre even tried getting FUA to do what we needed, no such luck there.
>Some other bigger OS wanted it differently, the rest is history.

Lo siento, I wasn't around when that occurred.  Of course, that other
bigger OS has a very large installed base, and selling a drive that
breaks it is corporate suicide.


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

