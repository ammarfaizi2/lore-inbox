Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423815AbWJaT0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423815AbWJaT0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423816AbWJaT0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:26:25 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:40719 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423815AbWJaT0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:26:24 -0500
Date: Tue, 31 Oct 2006 19:26:13 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061031192613.GB26625@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin J. Bligh" <mbligh@google.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45477668.4070801@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:14:32AM -0800, Martin J. Bligh wrote:
> >But I've become innoculated against warnings, just because we have too 
> >many of the totally useless noise about deprecation and crud, and ppc has 
> >it's own set of bogus compiler-and-linker-generated warnings..
> >
> >At some point we should get rid of all the "politeness" warnings, just 
> >because they can end up hiding the _real_ ones.
> 
> Yay! Couldn't agree more. Does this mean you'll take patches for all the
> uninitialized variable crap from gcc 4.x ?

Why not apply pressure to gcc people to fix their compiler warning bugs
instead?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
