Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261500AbSIWWFC>; Mon, 23 Sep 2002 18:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbSIWWFC>; Mon, 23 Sep 2002 18:05:02 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:28545 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261500AbSIWWFB>; Mon, 23 Sep 2002 18:05:01 -0400
Date: Mon, 23 Sep 2002 15:10:02 -0700
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923221002.GA3209@gnuppy.monkey.org>
References: <20020923083004.B14944@work.bitmover.com> <Pine.LNX.4.44.0209231433560.16864-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209231433560.16864-100000@twinlark.arctic.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 02:41:33PM -0700, dean gaudet wrote:
> so while this is I/O, it's certainly less efficient to have thousands of
> tasks blocked in read(2) versus having thousands of entries in <pick your
> favourite poll/select/etc. mechanism>.

NIO in the recent 1.4 J2SE solves this problem now and threads don't have to
be abused.

bill

