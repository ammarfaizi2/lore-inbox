Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270576AbUJTWT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270576AbUJTWT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270374AbUJTWSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:18:40 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:55198 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270563AbUJTWRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:17:05 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j0AkqcXk03qiRG22S97yDOkhIBDoI3mMyk5s4Lwf9JLhnNwEH2++matpentyyC868N4lktI5JzqPwodrmWFZrfIu2oCoLkvKNFYFeDXow0zSPCXzzCJxTF/neB7NTXwBCPaPxgw5Y/C2hOe6V044OcsJ7ByInVoVc0AMPQFHJRw
Message-ID: <7f800d9f04102015174e7356a@mail.gmail.com>
Date: Wed, 20 Oct 2004 15:17:05 -0700
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Timothy Miller <miller@techsource.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4176E08B.2050706@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4176E08B.2050706@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 18:02:51 -0400, Timothy Miller
<miller@techsource.com> wrote:
> In short, what I have been proposing to my superiors is the development
> of a graphics card specifically for open source systems. 

That sounds truly great! However...

If the graphics card mostly supports 2D initially, it's really not
much better then just about any off the shelf graphics card with VESA
drivers. As in, the hardware doesn't need to be open for just that.
Most (all?) the frustration in Linux graphics card land comes from
unsupported/closed 3D drivers.

I obviously understand that it would be very costly to try to catch up
with ATI/NVidia in 3D land, but if you manage to get an open platform
out there which has great 3D potential (hardware wise) and is easily
programmable, I am sure the open source community would _love_ to try
to jointly develop fast 3D firmware (and drivers). That way Techsource
won't have to front the cost (other than for hardware).

So a open, programmable 3D hardware platform would open the door for
open source 3D engine innovation.

If you get this off the road, that would be very impressive and most
exciting to watch.

However, if you're only going to focus on 2D, I don't see the
excitement. 2D works pretty much for everyone, no?

Cheers,
    Andre
