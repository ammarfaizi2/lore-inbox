Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318721AbSIKLoZ>; Wed, 11 Sep 2002 07:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSIKLoZ>; Wed, 11 Sep 2002 07:44:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318721AbSIKLoY>;
	Wed, 11 Sep 2002 07:44:24 -0400
Date: Wed, 11 Sep 2002 13:49:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911114903.GK1089@suse.de>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain> <20020911120551.A937@namesys.com> <20020911102507.GA1364@suse.de> <20020911102926.GB1364@suse.de> <20020911144740.A911@namesys.com> <20020911105807.GF1089@suse.de> <20020911151602.A830@namesys.com> <20020911111726.GJ1089@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911111726.GJ1089@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Jens Axboe wrote:
> > Ok, with other patch it still fails in the same way.
> > I have not backed out other patch so I tested with both patches perent.
> 
> alright, seems I do have to try it myself... ok will do that.

with both patches I sent applied, the bug does _not_ exist here as
expected. could you please double check that they are applied, and that
you have booted the right kernel? a make clean just to be on the safe
side might be a good idea :-)

-- 
Jens Axboe

