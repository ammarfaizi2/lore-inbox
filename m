Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTBYC1C>; Mon, 24 Feb 2003 21:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTBYC1C>; Mon, 24 Feb 2003 21:27:02 -0500
Received: from almesberger.net ([63.105.73.239]:35086 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265242AbTBYC06>; Mon, 24 Feb 2003 21:26:58 -0500
Date: Mon, 24 Feb 2003 23:37:01 -0300
From: Werner Almesberger <wa@almesberger.net>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224233701.J2791@almesberger.net>
References: <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224233638.GS10411@holomorphy.com> <20030225002309.GA12146@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225002309.GA12146@work.bitmover.com>; from lm@bitmover.com on Mon, Feb 24, 2003 at 04:23:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> The point is that if you are putting SMP changes into the system, you
> have to be held to a higher standard for measurement given the past
> track record of SMP changes increasing code length and cache footprints.

So you probably want to run this benchmark on a synthetic CPU a la
cachegrind. The difficult part would be to come up with a reasonably
understandable additive metric for cache pressure.

(I guess there goes another call to arms to academia :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
