Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbULFXS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbULFXS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULFXSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:18:15 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:58803 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261698AbULFXOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:14:34 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: The bugzilla story
Date: Tue, 7 Dec 2004 00:15:37 +0100
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Nyberg <alexn@dsv.su.se>,
       "Martin J. Bligh" <mbligh@aracnet.com>, zwane@holomorphy.com,
       akpm@osdl.org
References: <1102342960.727.59.camel@boxen> <1102350405.727.79.camel@boxen> <1102349678.14484.11.camel@localhost.localdomain>
In-Reply-To: <1102349678.14484.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200412070015.37711.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 of December 2004 17:14, Alan Cox wrote:
> On Llu, 2004-12-06 at 16:26, Alexander Nyberg wrote:
> > The thing is that -mm changes so fast that a bug reported can be solved
> > an hour later, leaving a stale bug report for a few days (or years).
> > Whoever wants to pick up the bug quite much has to mail either the
> > bug-submitter asking if the bug has been resolved, mail the maintainer
> > of whatever area the bug concerns or mail akpm.

I have stopped reporting the -mm issues using bugizlla exactly for this 
reason.  Apparently, the reports get more attention when they are sent to 
LKML. ;-)

> > This leads me to thinking that bugzilla doesn't serve any functionality
> > for at least -mm.
> 
> Sometimes they do - for looking back and finding when a problem came in,
> or for spotting common patterns. They are less useful but not of no use

Yes, but many things are not reported there anyway.  IMVHO the bugzilla is an 
overkill for -mm bug reporting.  The -mm kernels are released too often, they 
change too much, and the issues are often too simple to be reported this way.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
