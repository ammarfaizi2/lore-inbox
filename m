Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282837AbRK0Hjp>; Tue, 27 Nov 2001 02:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282839AbRK0Hjg>; Tue, 27 Nov 2001 02:39:36 -0500
Received: from queen.bee.lk ([203.143.12.182]:25760 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S282840AbRK0Hj1>;
	Tue, 27 Nov 2001 02:39:27 -0500
Date: Tue, 27 Nov 2001 13:39:02 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Release Policy
Message-ID: <20011127133902.A21914@bee.lk>
In-Reply-To: <4.3.2.7.2.20011126113409.00bfaa70@mail.osagesoftware.com> <Pine.LNX.4.21.0111261328450.13681-100000@freak.distro.conectiva> <3C02E682.4CDC6858@zip.com.au> <20011126.171301.50592818.davem@redhat.com> <9tuqf2$eri$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9tuqf2$eri$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Nov 26, 2001 at 05:32:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 26, 2001 at 05:32:18PM -0800, H. Peter Anvin wrote:
> > 
> > Such updates really only need to go through his "stupid filter"
> > when it is coming from the maintainer, but it does add up and
> > take up time.
> 
> Obviously.  If it's for a maintained subsystem:
> 
> a) if it's from the subsystem maintainer, sanity-check it.
> b) if it's not, dump it or reject with the appropriate notice.

A minor issue...

How does Marcelo (or Linus or Alan, say) know that the patch _really_ came from
the subsystem aintainer himself?  I mean anybody would have sent any crap, but
not too bad enough to suspect.  But if it came with a CC to a list, there is a
much smaller chance of this happenning.

Yes.  This would be very rare and the effects would be very short lived.  But
still the _possibility_ exists.

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

When you make your mark in the world, watch out for guys with erasers.
		-- The Wall Street Journal

