Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277170AbRJDIGq>; Thu, 4 Oct 2001 04:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277171AbRJDIGh>; Thu, 4 Oct 2001 04:06:37 -0400
Received: from dsl-45-169.muscanet.com ([208.164.45.169]:56328 "EHLO
	dink.joshisanerd.com") by vger.kernel.org with ESMTP
	id <S277170AbRJDIG2>; Thu, 4 Oct 2001 04:06:28 -0400
Date: Thu, 4 Oct 2001 03:06:57 -0500 (CDT)
From: Josh Myer <jbm@joshisanerd.com>
To: linux-kernel@vger.kernel.org
Subject: Re: USB Event Daemon?
In-Reply-To: <Pine.LNX.4.21.0110040158530.31009-100000@dignity.joshisanerd.com>
Message-ID: <Pine.LNX.4.21.0110040305380.31009-100000@dignity.joshisanerd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I feel stupid.

Decided to look over Documentation/usb again and scour the web some
more. Hotplug support is exactly what i was looking for (ie: i've already
got a shell script that just grabs the files already thrown together).

Sorry to clutter the list.
-josh, random moron

On Thu, 4 Oct 2001, Josh Myer wrote:

> Hi,
> 
> This might belong on linux-usb, but i'm not subscribed there, and I figure
> this is probably a better place to ask this question.
> 
> Is there, or if there were, would it be used, a method to notify a
> user-space daemon/program of USB device insertions? A quick search through
> archives didn't show anything.
> 
> Basically, i've been spoiled by OSX's "Image Capture" utility, which
> launches an image offloader whenever i plug my camera into the USB port,
> automatically mounting it as a USB storage device. I'd like similiar
> functionality on my linux machine(s).
> 
> My first instinct is to look at the new input layer and see if this would
> fit into that scheme.
> 
> Any thoughts, pointers, or flamage would be appreciated; i'm sub'd, but
> CCs are appreciated to help seperate signal and noise.
> 
> Thanks in advance,
> -- 
> /jbm, but you can call me Josh. Really, you can.
>  "Design may be clever in spurts,
>   but evolution never sleeps"
>   -- Rob Landley
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
/jbm, but you can call me Josh. Really, you can.
 "Design may be clever in spurts,
  but evolution never sleeps"
  -- Rob Landley

