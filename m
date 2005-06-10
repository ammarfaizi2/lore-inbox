Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVFJPly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVFJPly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVFJPkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:40:47 -0400
Received: from stark.xeocode.com ([216.58.44.227]:39397 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S262575AbVFJPgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:36:07 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Greg Stark <gsstark@mit.edu>, Mark Lord <liml@rtr.ca>,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com>
	<87br6g6ayr.fsf@stark.xeocode.com> <42A73E6E.80808@rtr.ca>
	<873brs5ir8.fsf@stark.xeocode.com> <42A85F5E.10208@rtr.ca>
	<87u0k74cuy.fsf@stark.xeocode.com> <20050610063858.GN5140@suse.de>
In-Reply-To: <20050610063858.GN5140@suse.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 10 Jun 2005 11:35:44 -0400
Message-ID: <87oeae4433.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> > > Greg Stark wrote:
> > 
> > What I should *really* be using is the noflushd daemon. That's been on hold
> > since I found it didn't work with SATA drives. But I wonder if it would work
> > these days.
> 
> noflushd is ancient, have you tried playing with laptop mode?

Where do I find more about this?

-- 
greg

