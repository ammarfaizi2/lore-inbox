Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRK1SzR>; Wed, 28 Nov 2001 13:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279951AbRK1SzH>; Wed, 28 Nov 2001 13:55:07 -0500
Received: from junk.nocrew.org ([212.73.17.42]:13010 "EHLO junk.nocrew.org")
	by vger.kernel.org with ESMTP id <S279934AbRK1Syu>;
	Wed, 28 Nov 2001 13:54:50 -0500
To: Eric Weigle <ehw@lanl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Magic Lantern
In-Reply-To: <Pine.LNX.3.95.1011128090654.10732B-100000@chaos.analogic.com>
	<20011128081305.I22767@lanl.gov>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Organization: nocrew
Date: 28 Nov 2001 19:54:39 +0100
In-Reply-To: <20011128081305.I22767@lanl.gov>
Message-ID: <85oflmvi8g.fsf@junk.nocrew.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Weigle <ehw@lanl.gov> writes:
> > > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > > > Basically, a "tee" to capture all network packets and pass them
> > > > on to a filtering task without affecting normal network activity.
> > > The af_packet module can read and write raw ethernet frames.
> The af_packet module may also be fairly inefficient. If you need
> performance over, say, a gigabit link, you may have trouble.

Are you (or anyone else) aware of any alternative?

-- 
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming
