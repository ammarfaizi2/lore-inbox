Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265660AbSJXUW6>; Thu, 24 Oct 2002 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbSJXUW6>; Thu, 24 Oct 2002 16:22:58 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:40196 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265660AbSJXUW5>; Thu, 24 Oct 2002 16:22:57 -0400
Date: Thu, 24 Oct 2002 21:29:10 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
Message-ID: <20021024202910.GA16192@compsoc.man.ac.uk>
References: <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB85213.4020509@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB85213.4020509@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 03:03:31PM -0500, Corey Minyard wrote:

> >               if (CTR_OVERFLOWED(low)) {
> >			... found
> >
> Any way to do this for the IO_APIC case?

Ugh, forgot about that. I have no idea, sorry

regards
john

-- 
"This is playing, not work, therefore it's not a waste of time."
	- Zath
