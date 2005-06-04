Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVFDPYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFDPYv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVFDPYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:24:51 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:31414 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261382AbVFDPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:24:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12?
Date: Sat, 4 Jun 2005 17:24:53 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
References: <42A0D88E.7070406@pobox.com> <394120000.1117895039@[10.10.2.4]> <398710000.1117895711@[10.10.2.4]>
In-Reply-To: <398710000.1117895711@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506041724.54558.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 4 of June 2005 16:35, Martin J. Bligh wrote:
> 
> --"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Saturday, June 04, 2005 07:23:59 -0700):
> 
> > 
> > 
> > --Andrew Morton <akpm@osdl.org> wrote (on Friday, June 03, 2005 16:38:43 -0700):
> > 
> >> Jeff Garzik <jgarzik@pobox.com> wrote:
> >>> 
> >>> 
> >>> So...  are we gonna see 2.6.12 sometime soon?
> >>> 
> >> 
> >> Current plan is -rc6 in a few days, 2.6.12 a week after that.
> >> 
> >> 
> >> My things-to-worry-about folder still has 244 entries.  Nobody seems to
> >> care much.  Poor me.
> >> 
> >> Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
> >> the usual suspects.
> > 
> > The one that worries me is that my x86_64 box won't boot since -rc3
> > See:
> > 
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> > 
> > Note large amount of red in left hand column. Backing out the fusion
> > patches to the previous rev didn't fix it.
> 
> Filed bug 4709 to track it.

Well, I have a dual-Opteron box with tg3 (AMD chipset) and -rc5+ run happily on it.
Please let me know if I can help somehow.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
