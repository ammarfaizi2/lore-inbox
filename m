Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265755AbSJTDo4>; Sat, 19 Oct 2002 23:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265756AbSJTDo4>; Sat, 19 Oct 2002 23:44:56 -0400
Received: from ns.suse.de ([213.95.15.193]:23050 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265755AbSJTDo4>;
	Sat, 19 Oct 2002 23:44:56 -0400
Date: Sun, 20 Oct 2002 05:50:59 +0200
From: Andi Kleen <ak@suse.de>
To: george anzinger <george@mvista.com>
Cc: Andi Kleen <ak@suse.de>, Jim Houston <jim.houston@attbi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: POSIX clocks & timers - more choices
Message-ID: <20021020055059.B30135@wotan.suse.de>
References: <200210190252.g9J2quf16153@linux.local.suse.lists.linux.kernel> <p73r8ennltj.fsf@oldwotan.suse.de> <3DB102BC.F181BC1F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB102BC.F181BC1F@mvista.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:59:08PM -0700, george anzinger wrote:
> What do you suggest?  Changing mips?  I would like this
> number to go away also, but with the mips assignments it is
> a bit of a bother.

Yes, mips should be probably changed or a new macro be defined.

-Andi
