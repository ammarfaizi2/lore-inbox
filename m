Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTKXUef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTKXUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:34:35 -0500
Received: from thunk.org ([140.239.227.29]:5843 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263922AbTKXUee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:34:34 -0500
Date: Mon, 24 Nov 2003 15:33:21 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Larry McVoy <lm@bitmover.com>, Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: data from kernel.bkbits.net
Message-ID: <20031124203321.GA9036@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Larry McVoy <lm@bitmover.com>, Ricky Beam <jfbeam@bluetronic.net>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <20031124155034.GA13896@work.bitmover.com> <Pine.GSO.4.33.0311241405070.13188-100000@sweetums.bluetronic.net> <20031124192432.GA20839@work.bitmover.com> <Pine.LNX.4.53.0311241459320.2333@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0311241459320.2333@chaos>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 03:05:24PM -0500, Richard B. Johnson wrote:
> Attempt to copy the raw drive to /dev/null.  If that works, the
> drive is likely okay, but the fs got fsucked up by software. You
> might be able to mount the drive on a 2.4.22 machine if you have a
> spare. Then you might be able to selectively copy important stuff
> to another drive, after which you can make a new file-system as
> a "repair".

The error messages Larry reported were obviously reported by the
hardware, and were **not** filesystem errors. 

						- Ted
