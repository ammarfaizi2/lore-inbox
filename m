Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276532AbRJRHJ2>; Thu, 18 Oct 2001 03:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277434AbRJRHJR>; Thu, 18 Oct 2001 03:09:17 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:46862 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S276532AbRJRHJA>; Thu, 18 Oct 2001 03:09:00 -0400
Date: Thu, 18 Oct 2001 17:09:17 +1000
From: john slee <indigoid@higherplane.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: James D Strandboge <jstrand1@rochester.rr.com>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: joypad bug
Message-ID: <20011018170917.D5511@higherplane.net>
In-Reply-To: <000801c15672$bed14210$1300a8c0@marcelo> <20011017212342.A552@suse.cz> <20011017153214.A12797@rochester.rr.com> <20011017224337.A319@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011017224337.A319@suse.cz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 10:43:37PM +0200, Vojtech Pavlik wrote:
> On Wed, Oct 17, 2001 at 03:32:14PM -0400, James D Strandboge wrote:
> > On Wed, Oct 17, 2001 at 09:23:42PM +0200 or thereabouts, Vojtech Pavlik wrote:
> > > On Tue, Oct 16, 2001 at 03:30:40PM -0300, Marcelo Borges Ribeiro wrote:
> > > > I'm using 2.4.12 and since 2.4.10 my 8-button joypad (via gameport) stoped
> > > > working.
> > > > The first 4 buttons work but directions and other 4 buttons doesn?t. I did
> > > > not notice nothing
> > > > about it in changelog so I?m reporting it.
> > > 
> > > I know about the problem in 2.4.10. But in 2.4.12 that should be fixed ...
> > > 
> > I am using kernel 2.4.12 now, and my Logitech WIngman Attack (analog driver)
> > has the same symptions.  Buttons work, directions don't.
> 
> Uh-uh. Gotta get me an analog joystick fast and test this.

unless it specifically has to be gameport, probably the easiest, best,
and cheapest way is to buy a playstation => usb adapter (~20AUD from
http://www.lik-sang.com) and a playstation controller or two.  psx
dualshock controller costs ~50AUD and gives you 12 buttons, two analog
sticks, and a dpad... (in an imho very comfortable-to-use package)

you could then also use the dualshock to test bugs in the parallel port
psx driver, i believe the adapters are quite cheap to make and have the
added benefit of having the vibration feature supported (whereas it
doesnt seem to work with the usb adapter)

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
