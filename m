Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbSJMU1t>; Sun, 13 Oct 2002 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbSJMU1s>; Sun, 13 Oct 2002 16:27:48 -0400
Received: from f213.law8.hotmail.com ([216.33.241.213]:9476 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261747AbSJMU1q>;
	Sun, 13 Oct 2002 16:27:46 -0400
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT400 & VT8235 support
Date: Sun, 13 Oct 2002 16:33:33 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F21342AEykwwgjUwkbz000172d1@hotmail.com>
X-OriginalArrivalTime: 13 Oct 2002 20:33:33.0374 (UTC) FILETIME=[CC87DDE0:01C272F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Vojtech Pavlik <vojtech@suse.cz>
.............
>
>On Sat, Oct 12, 2002 at 04:40:15PM -0400, sean darcy wrote:
>
> > Before spending money on a new VIA motherboard with the KT400 and VT8235
> > south bridge, I'd like to know if they're supported in 2.4 and 2.5. Are
> > they?
>
>2.5 supports it, 2.4 needs a patch.
>
>--
>Vojtech Pavlik
>SuSE Labs


Well, sort of. I actually found someone who had one. Booted up 2.5.42. 
Everything seems to work except agpgart:

agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Unsupported Via chipset (device id: 3189), you might want to try 
agp_try_unsupported=1.
agpgart: no supported devices found.

Is there a patch for 2.4? In one of the pre's?

thanks
jay



_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

