Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318738AbSIKMFh>; Wed, 11 Sep 2002 08:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318742AbSIKMFh>; Wed, 11 Sep 2002 08:05:37 -0400
Received: from angband.namesys.com ([212.16.7.85]:2432 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318738AbSIKMFh>; Wed, 11 Sep 2002 08:05:37 -0400
Date: Wed, 11 Sep 2002 16:10:21 +0400
From: Oleg Drokin <green@namesys.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911161021.A962@namesys.com>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain> <20020911120551.A937@namesys.com> <20020911102507.GA1364@suse.de> <20020911102926.GB1364@suse.de> <20020911144740.A911@namesys.com> <20020911105807.GF1089@suse.de> <20020911151602.A830@namesys.com> <20020911111726.GJ1089@suse.de> <20020911114903.GK1089@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020911114903.GK1089@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 01:49:03PM +0200, Jens Axboe wrote:
> > > Ok, with other patch it still fails in the same way.
> > > I have not backed out other patch so I tested with both patches perent.
> > alright, seems I do have to try it myself... ok will do that.
> with both patches I sent applied, the bug does _not_ exist here as
> expected. could you please double check that they are applied, and that
> you have booted the right kernel? a make clean just to be on the safe
> side might be a good idea :-)

Well, now it works for me too. Not sure why it was working previous time,
because all the patches were in place. I will play more with it later today.

Thanks.

Bye,
    Oleg
