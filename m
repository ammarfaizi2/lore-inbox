Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282844AbRK0Hy0>; Tue, 27 Nov 2001 02:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282847AbRK0HyS>; Tue, 27 Nov 2001 02:54:18 -0500
Received: from queen.bee.lk ([203.143.12.182]:31648 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S282844AbRK0HxZ>;
	Tue, 27 Nov 2001 02:53:25 -0500
Date: Tue, 27 Nov 2001 13:53:01 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Anuradha Ratnaweera <anuradha@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Release Policy
Message-ID: <20011127135301.A22598@bee.lk>
In-Reply-To: <4.3.2.7.2.20011126113409.00bfaa70@mail.osagesoftware.com> <Pine.LNX.4.21.0111261328450.13681-100000@freak.distro.conectiva> <3C02E682.4CDC6858@zip.com.au> <20011126.171301.50592818.davem@redhat.com> <9tuqf2$eri$1@cesium.transmeta.com> <20011127133902.A21914@bee.lk> <3C03436E.5020705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C03436E.5020705@zytor.com>; from hpa@zytor.com on Mon, Nov 26, 2001 at 11:40:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 11:40:30PM -0800, H. Peter Anvin wrote:
> Anuradha Ratnaweera wrote:
> > 
> > How does Marcelo (or Linus or Alan, say) know that the patch _really_ came from
> > the subsystem aintainer himself?  I mean anybody would have sent any crap, but
> > not too bad enough to suspect.  But if it came with a CC to a list, there is a
> > much smaller chance of this happenning.
> > 
> > Yes.  This would be very rare and the effects would be very short lived.  But
> > still the _possibility_ exists.
> 
> How about sending a quick reply "got your patch, applied it?"  The 
> maintainer can then say "WHAT PATCH?"

Don't we need a consistent indexing system for patches?

May be the subsystem maintainers can upload patches to some place over ssh/ssl
and the maintainer can _download_ them from there. The maintainer will simply
email the patch number and not the whole thing. And patches can be
numbered/named in some consistent manner.  Once the system is in place, we can
even automate md5 checksums etc.

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

There's one consolation about matrimony.  When you look around you can
always see somebody who did worse.
		-- Warren H. Goldsmith

