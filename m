Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVADVIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVADVIC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVADVFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:05:16 -0500
Received: from THUNK.ORG ([69.25.196.29]:17575 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261869AbVADVEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:04:50 -0500
Date: Tue, 4 Jan 2005 16:01:17 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Adrian Bunk <bunk@stusta.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       davidsen@tmr.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104210117.GA7280@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Adrian Bunk <bunk@stusta.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Diego Calleja <diegocg@teleline.es>,
	Willy Tarreau <willy@w.ods.org>, davidsen@tmr.com, aebr@win.tue.nl,
	solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
References: <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103142412.490239b8.diegocg@teleline.es> <20050103134727.GA2980@stusta.de> <20050104125738.GC2708@holomorphy.com> <20050104150810.GD3097@stusta.de> <20050104153445.GH2708@holomorphy.com> <20050104165301.GF3097@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104165301.GF3097@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 05:53:01PM +0100, Adrian Bunk wrote:
> 
> My opinion is to fork 2.7 pretty soon and to allow into 2.6 only the 
> amount of changes that were allowed into 2.4 after 2.5 forked.
> 
> Looking at 2.4, this seems to be a promising model.

You have *got* to be kidding.  In my book at least, 2.4 ranks as one
of the less successful stable kernel series, especially as compared
against 2.2 and 2.0.  2.4 was far less stable, and a vast number of
patches that distributions were forced to apply in an (only partially
successful) attempt to make 2.4 stable meant that there are some
2.4-based distributions where you can't even run with a stock 2.4
kernel from kernel.org.  Much of the reputation that Linux had of a
rock-solid OS that never crashed or locked up that we had gained
during the 2.2 days was tarnished by 2.4 lockups, especially in high
memory pressure situations.

One of the things which many people have pointed out was that even
2.6.0 was more stable than 2.4 was for systems under high load.

						- Ted
