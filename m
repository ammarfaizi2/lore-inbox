Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269046AbUHZP0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269046AbUHZP0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUHZP0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:26:53 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:46522 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269046AbUHZPZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:25:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
Subject: Re: 2.6.9-rc1-mm1
Date: Thu, 26 Aug 2004 17:35:33 +0200
User-Agent: KMail/1.5
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <200408261636.06857.rjw@sisk.pl> <200408261646.08419.lkml@felipe-alfaro.com>
In-Reply-To: <200408261646.08419.lkml@felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408261735.33573.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 of August 2004 16:45, Felipe Alfaro Solana wrote:
> On Thursday 26 August 2004 16:36, Rafael J. Wysocki wrote:
> > I think the problem is that relatively not so many people run -mm, and
> > even less people try to use them for a longer time.  Also, there
> > sometimes are some issues with -mm that must be sorted out first, but
> > then there's not much time left for testing the scheduler before the next
> > -mm.
>
> I think this is the main reason of existence for -mm kernels: find
> problems, sort them out and fix them.

That's the point.  You don't pay attention to the differences between 
schedulers if there are more serious problems, do you?

> I've been running -mm kernels since
> 2.5.80+ and all problems I have had were resolved in a timely manner.

I agree, but it's a different thing. :-)

> What I think is that Con's scheduler is the one that needs to get into -mm
> kernels to give it more exposure. Currently, it has a very limited
> audience.

IMHO, -mm could stick for a while with one of the alternative schedulers so 
that it gets more testing.

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
