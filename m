Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSG2NAT>; Mon, 29 Jul 2002 09:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSG2NAT>; Mon, 29 Jul 2002 09:00:19 -0400
Received: from maile.telia.com ([194.22.190.16]:22734 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S316437AbSG2NAS>;
	Mon, 29 Jul 2002 09:00:18 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: David Ford <david+cert@blue-labs.org>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net
Subject: Re: Linux booting from USB HD / USB interface devices
Date: Mon, 29 Jul 2002 15:02:30 +0200
User-Agent: KMail/1.4.5
References: <3D42E333.4010602@blue-labs.org>
In-Reply-To: <3D42E333.4010602@blue-labs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200207291502.30926.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 July 2002 20.15, David Ford wrote:
> Linux booting from USB HD
> 
> I've been doing some research in this area.  There are a few 
> motherboards that I've come across that are capable of booting from a 
> USB hard drive and I'm interested in collecting a lot of opinions and 
> "yeah, i've done that" comments.  The end application for this is to 
> mount a motherboard in a 4x4 truck to process dash data and sensory 
> input (i.e. GPS, atmospheric, fire department data, etc), provide 
> digitized maps (GIS), network connectivity via wireless, and be the 
> radio/mp3/cd player etc.

Maybe you are asking for the wrong thing here...
What you want is probably an "flash based persistent storage that can be 
booted from" not specifically USB - correct?

If that is the case - you do not want to use USB memory but rather
CompactFlash - since they are both compatible with PCMCIA _and_ IDE.
You only need a ribbon cable and a small adapter (the adapter is really 
simple)!

A quick search on google for "CompactFlash IDE" or "Compact flash IDE" will 
give you several hits.

Since they are compatible with IDE you can use any MB including
most PC/104 variant - many of those can also be booted from DiskOnChip...

> 
> The most promising vendor I've found so far is Gigabyte, one of the 
> better motherboards appears to be the GA-8IGX model.
> 
> _Please note_, I'm specifically trying to use a USB harddrive, not a 
> floppy.  I want the smallest number of devices required to run the 
> system and floppy media is just too unreliable.  I'm also intending on 
> putting the harddrive several feet away from the motherboard -- the 
> system's physical profile has to be flexible.

An compact flash IDE is VERY small... If you can not fit it in the case you
have other problems...
 
/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

