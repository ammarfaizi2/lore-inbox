Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVKVArX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVKVArX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVKVArX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 19:47:23 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:39753 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964806AbVKVArW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 19:47:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ha4WcWa62cnx7sZW5GoxO/htIQliaTsC3gkZ+15Uup3+FLihSLA8xPzf2QKwuaR+h4ukfjy9/Lz1watRp4oMl2IEYutr0AQiRoL9qDKuQdLv+QYZpJJDcVpMPx0IPNe96d6h21S3WdsaGXJ7021IIoCU7c6fmFxHT4ynnrERVoA=
Message-ID: <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
Date: Tue, 22 Nov 2005 11:47:21 +1100
From: Dave Airlie <airlied@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Small PCI core patch
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1132616132.26560.62.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm all about it, but good luck trying to convince ATI and/or nVidia ...
>
> For those who haven't noticed, the latest generation of ATI cards have a
> new 2D engine that is completely different from the previous one and
> totally undocumented. So far, they haven't showed any plans to provide
> any kind of documentation for it, unlike what they did for previous
> chipsets, not even 2D and not even under NDA. That means absolutely _0_
> support for it in linux or X.org except maybe with some future version
> of their binary blob, and _0_ support for it for any non-x86
> architecture of course.
>
> At least nVidia still sort-of maintains the obfuscated but working &
> opensource basic 2D driver ...
>
> On the graphics front, things are actually getting _worse_ everyday.
>

And funny enough unlike SCSI adapters and things for large server
installations, nobody seems to really care enough about graphics
cards, I've heard horror stories about how little Linux companies
actually care about open source graphics, I suppose they have to
follow the profit but still you'd like to think they effect of all
this "open source drivers, get them in the kernel" work that is being
done would at some point spill over ....

When someone gets up of their arse and sues nvidia or ATI and wins,
then feel free to change these exports, otherwise your view on who is
right has as much legal value as their view, whether we like it or
not..

Dave.
