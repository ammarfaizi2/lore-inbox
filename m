Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbSIRP3X>; Wed, 18 Sep 2002 11:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSIRP3X>; Wed, 18 Sep 2002 11:29:23 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:61399 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S266962AbSIRP3X>;
	Wed, 18 Sep 2002 11:29:23 -0400
Date: Wed, 18 Sep 2002 09:31:11 -0600
From: yodaiken@fsmlabs.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Cort Dougan <cort@fsmlabs.com>, William Lee Irwin III <wli@holomorphy.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918093111.A9315@hq.fsmlabs.com>
References: <20020918090104.E14918@host110.fsmlabs.com> <Pine.LNX.4.44.0209181711350.22395-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209181711350.22395-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 18, 2002 at 05:33:54PM +0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 05:33:54PM +0200, Ingo Molnar wrote:
> On Wed, 18 Sep 2002, Cort Dougan wrote:
> 
> > Can we get a lockless, scalable, fault-tolerant, pre-emption safe,
> > zero-copy and distributed get_pid() that meets the Carrier Grade
> > specification? [...]
> 
> of course, and it should also be massively-threaded, LSB-compliant,
> enterprise-ready, secure, cluster-aware, power-saving and self-healing. I
> admit that there's still lots of work to be done, but there's just so many
> hours in a day.

The ecosystem thanks you for your efforts.


