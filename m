Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277278AbRJRMqM>; Thu, 18 Oct 2001 08:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277598AbRJRMpw>; Thu, 18 Oct 2001 08:45:52 -0400
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:44790 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S277278AbRJRMpq>; Thu, 18 Oct 2001 08:45:46 -0400
Date: Thu, 18 Oct 2001 08:46:07 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: joypad bug
Message-ID: <20011018084607.A626@rochester.rr.com>
In-Reply-To: <000801c15672$bed14210$1300a8c0@marcelo> <20011017212342.A552@suse.cz> <20011017153214.A12797@rochester.rr.com> <20011017224337.A319@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011017224337.A319@suse.cz>
User-Agent: Mutt/1.3.20i
From: jstrand1@rochester.rr.com (James D Strandboge)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 10:43:37PM +0200 or thereabouts, Vojtech Pavlik wrote:
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
> 
I just confirmed that joystick works properly in 2.4.9.

Jamie

-- 
GPG/PGP Info
Email:        jstrand1@rochester.rr.com
ID:           26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A
--
