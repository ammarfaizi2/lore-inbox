Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268101AbTAKTFH>; Sat, 11 Jan 2003 14:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268102AbTAKTFH>; Sat, 11 Jan 2003 14:05:07 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:20997 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268101AbTAKTFF>; Sat, 11 Jan 2003 14:05:05 -0500
Date: Sat, 11 Jan 2003 19:13:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: make AT_SYSINFO platform-independent
Message-ID: <20030111191347.A5413@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ulrich Drepper <drepper@redhat.com>, davidm@hpl.hp.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200301110645.h0B6jQRu026921@napali.hpl.hp.com> <20030111110717.A24094@infradead.org> <3E2067FE.4060803@redhat.com> <20030111185744.A5009@infradead.org> <3E206B41.2090203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E206B41.2090203@redhat.com>; from drepper@redhat.com on Sat, Jan 11, 2003 at 11:06:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:06:41AM -0800, Ulrich Drepper wrote:
> > glibc release yet and no stable kernel release yet with that number.
> 
> Of course there is.  You better don't talk about thinks you don't know.

The latest glibc release, 2.3.1 does not contain AT_SYSINFO support.
I might be not as briliant as you but I'm certainly not stupid.

> > Interfaces change during 2.5 (see the sys_security and largepage syscall
> > removal) and that's okay.  There was no nastiness involved in my
> > suggestion.
> 
> You don't get it.  I would never have distributed binaries with the
> current code if it wouldn't have been requested along with the guarantee
> that the current interface is stable and final.

Sorry, but having not yet fixed interfaces is the whole point of
development kernels.  If vendors can't resist using the latest and gratest
features they get screwed.  RH seems to have the manpower to maintain their
mistakes for a long enough time, so what's the issue?


