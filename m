Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbQKIMuj>; Thu, 9 Nov 2000 07:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130653AbQKIMu3>; Thu, 9 Nov 2000 07:50:29 -0500
Received: from [193.120.224.170] ([193.120.224.170]:43409 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129777AbQKIMuO>;
	Thu, 9 Nov 2000 07:50:14 -0500
Date: Thu, 9 Nov 2000 12:50:00 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Christoph Rohland <cr@sap.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <3A0A97D0.36C5913B@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.21.0011091247261.7475-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Michael Rothwell wrote:

> Why? I think the IBM GKHI code would be of tremendous value. It would
> make the kernel much more flexible, and for users, much more friendly.
> No more patch-and-recompile to add a filesystem or whatever. There's no
> reason to hamstring their efforts because of the possibility of binary
> modules. The GPL allows that, right? 

no gpl definitely does not alow binary modules.

afaik linus allows binary modules in most cases.

> So any developer of binary-only
> extensions using the GKHI would not be breaking the license agreement, I
> don't think. There's lots of binary modules right now -- VMWare, Aureal
> sound card drivers, etc.
> 
> I understand and agree with your desire for full source for everything,
> but I disagree that we should artificially limit people's ability to use
> Linux to solve their problems.
> -

--paulj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
