Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSHGHrh>; Wed, 7 Aug 2002 03:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSHGHrh>; Wed, 7 Aug 2002 03:47:37 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:22495 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S317096AbSHGHrg> convert rfc822-to-8bit;
	Wed, 7 Aug 2002 03:47:36 -0400
Date: Wed, 7 Aug 2002 09:51:06 +0200
Message-Id: <200208070751.g777p6Z10076@eday-fe6.tele2.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
To: "Jeff Chua" <jchua@fedex.com>
Subject: Sv: i810 sound broken...
MIME-Version: 1.0
X-EdMessageId: 0d43161c5611571443555b421e10414b505c635e5c44105049185541554b4c55511886
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, 7 Aug 2002, Thomas Munck Steenholdt wrote:
> 
> > >> I'm afraid even that didn't help much - Only now I get a different
> kind
> > >> of error... Before, trying to play a sound, the operation would
> just
> > >> fisish immediatelyand a few noises were heard in the speakers...
> Now
> the
> > >> operation never finishes - still no sound... and I found these
> error
> > >> messages in dmesg..
> > >
> > >one last try ...
> > >
> > >unload all network, scsi, modems. Bare minimum and see if the sound
> alone
> > >would work. Again, use "aumix" before playing anything.
> > >
> > >Jeff
> > >
> >
> > Same situation with nothing loaded but the essential modules... heck I
> > even unloaded the cdrom module and it's exactly the same as before...
> > :-(
> 
> Really don't know what to do next. Alan, what do you think?
> 
> Another person got a similar problem, but he removed the network card,
> and
> the problem went away.
> 
> Also, have you tried hard boot, boot straight into Linux without booting
> Windows at all?
> 
> 
> Jeff
> 

Tried removing my network adaptor just to make sure - never booted from windows into linux, always hard boot into linux, and it still doesn't work... always aumix before trying anything, tried using playwave to test and also tried cat'ing a .wav to /dev/dsp... always the same result - hang and a couple of times the dma error shows up...

Thomas

-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

