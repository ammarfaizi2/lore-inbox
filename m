Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTDXVmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTDXVmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:42:09 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:36551 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264505AbTDXVmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:42:06 -0400
Subject: Re: 2.5.68 kernel no initrd
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       LKML <linux-kernel@vger.kernel.org>,
       =?iso-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>,
       Dave Mehler <dmehler26@woh.rr.com>
In-Reply-To: <Pine.LNX.3.96.1030424161618.11351B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030424161618.11351B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051221242.612.49.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 24 Apr 2003 23:54:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 22:19, Bill Davidsen wrote:
> > I don't have any doubts that initrd is a very flexible solution and
> > provides for a generic kernel. However, in the end (I'm talking about my
> > experiences), initrd has caused me more troubles than problems it
> > solved. I always keep all "config" file for every kernel I use on my
> > machines.
> 
> Other than needing to build and maintain all those kernels, what does it
> gain you over installing the  modules you need and having a single kernel?

Simply said, I don't like "initrd". I have still to figure out how to
make an "initrd" that includes the newer modutils.

Anyways, I don't mantain so much kernels (only 3 or 4 different
versions), and have a mix of AMD/P4/P3/P2/PI machines that need things
that can't be configured/don't yet work as modules, so I prefer to pass
initrd by...

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

