Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRJaXHv>; Wed, 31 Oct 2001 18:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJaXHl>; Wed, 31 Oct 2001 18:07:41 -0500
Received: from [204.42.16.60] ([204.42.16.60]:3849 "EHLO gerf.org")
	by vger.kernel.org with ESMTP id <S275224AbRJaXH1>;
	Wed, 31 Oct 2001 18:07:27 -0500
Date: Wed, 31 Oct 2001 17:08:04 -0600
From: The Doctor What <docwhat@gerf.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.13+preemptive lp0/devfs
Message-ID: <20011031170803.A15137@gerf.org>
Mail-Followup-To: The Doctor What <docwhat@gerf.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011031002549.A27188@gerf.org> <3BE058CA.6B1F89BA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3BE058CA.6B1F89BA@mvista.com>; from george@mvista.com on Wed, Oct 31, 2001 at 12:02:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* george anzinger (george@mvista.com) [011031 14:08]:
> Hm...  On the face of it, it looks like a read/write sem failed.  Is
> this an SMP box or UP?

Sorry: UP.  Never had the pleasure of owning a dual. :-)

> Oh, and is it repeatable?

Very.

> George

Ciao!

-- 
Cthulhu for President!
	(If you're tired of choosing the lesser of two evils.)

The Doctor What: Da Man                          http://docwhat.gerf.org/
docwhat@gerf.org                                                   KF6VNC
