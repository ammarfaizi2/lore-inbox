Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVCGECa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVCGECa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 23:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVCGECa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 23:02:30 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:35668 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261506AbVCGECU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 23:02:20 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Greg KH <greg@kroah.com>
Subject: Re: Linux 2.6.11.1
Date: Sun, 6 Mar 2005 23:01:59 -0500
User-Agent: KMail/1.7.2
References: <200503050116.10577.shawn.starr@rogers.com> <20050306050649.GC11889@kroah.com>
In-Reply-To: <20050306050649.GC11889@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503062302.00040.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, I can do this.  Wrt to trivial patches, will these patches that go into 
rusty's patch bot go into Linus's tree or into the -mm tree? 

The reason I ask that is because a trivial patch may fix an oops if there's an 
off-by-one problem and typically I'd submit that to the trivial patch bot.

That's why I was wondering about why this tree doesn't except trivial changes.

Thanks,
Shawn.


On March 6, 2005 00:06, you wrote:
> On Sat, Mar 05, 2005 at 01:16:10AM -0500, Shawn Starr wrote:
> > Sounds great, I can be a QA resource for what machines I have.
> >
> > How do people get involved in QAing these releases?
>
> Get the last release and test it out.  If you have problems, and have
> simple/obvious patches, send them on.
>
> thanks,
>
> greg k-h
