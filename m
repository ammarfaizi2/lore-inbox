Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUBWNqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUBWNqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:46:52 -0500
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:57095 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S261861AbUBWNqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:46:44 -0500
Message-Id: <4.3.2.7.2.20040223144245.01c2e688@pop.xs4all.nl>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 23 Feb 2004 14:46:34 +0100
To: Mikael Wahlberg <mikael.wahlberg@ardendo.se>,
       Christoph Hellwig <hch@infradead.org>
From: Seth Mos <knuffie@xs4all.nl>
Subject: Re: Filesystem kernel hangup, 2.6.3 (bad: scheduling while
  atomic!)
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Per Lejontand <pele@ardendo.se>,
       Jonas =?iso-8859-1?Q?Engstr=F6m?= <jonas@ardendo.se>
In-Reply-To: <1077541689.1247.12.camel@harrier>
References: <20040223121959.A8354@infradead.org>
 <20040222164941.D6046@foo.ardendo.se>
 <20040223121959.A8354@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:08 23-2-2004 +0100, Mikael Wahlberg wrote:
>On Mon, 2004-02-23 at 13:19, Christoph Hellwig wrote:
> > On Sun, Feb 22, 2004 at 04:49:41PM +0100, Mikael Wahlberg wrote:
> > did you run memtest86 on the box?  do you some strange patches applied or
> > external modules loaded?  What's your .config?
>
>No strange patches. Pure 2.6.3 dist kernel. We haven't run memtest86,
>but as I mentioned above, we have 4 equal machines with error correcting
>memory, so I find it unlikely to be a memory problem.

The memory might be fine, but the mainboard might still be borked. I have 
seen this once with Dell kit. Asuming can be dangerous. If you can spare 
the down time it is always a good idea to make sure.

In my experience XFS shows faulty memory quite fast. That's from personal 
experience.

Cheers

--
Seth
I don't make sense, I don't pretend to either. Questions?

