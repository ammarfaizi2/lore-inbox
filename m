Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUIDP55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUIDP55 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 11:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUIDP55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 11:57:57 -0400
Received: from frontend-1.hamburg.de ([212.1.41.126]:58622 "EHLO
	ebbe.int-rz.hamburg.de") by vger.kernel.org with ESMTP
	id S262418AbUIDP5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 11:57:55 -0400
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: dri-devel@lists.sourceforge.net, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: New proposed DRM interface design
Date: Sat, 4 Sep 2004 17:56:29 +0200
User-Agent: KMail/1.7
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, linux-kernel@vger.kernel.org,
       mharris@redhat.com
References: <20040904102914.B13149@infradead.org> <4139C8A3.6010603@tungstengraphics.com> <9e47339104090408362a356799@mail.gmail.com>
In-Reply-To: <9e47339104090408362a356799@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041756.29764.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 4. September 2004 17:36 schrieb Jon Smirl:
> On Sat, 04 Sep 2004 14:52:35 +0100, Keith Whitwell
>
> <keith@tungstengraphics.com> wrote:
> > Currently we have to perform two merges and three releases to get a
> > driver to a users:

> If DRM went into a kernel development model....
>
>          Release stable kernel  --> Picked up by vendor
>          Release stable Mesa 3D --> Picked up by vendor
>          Release stable X.org  --> Picked up by vendor
>
> This is the fastest model. Merges have been eliminated.
>
> You may think that X on GL (gnuLonghorn) is a crazy idea. But
> comptetive pressures from the Mac and Longhhorn will force us into
> doing it so or later. I'd rather do it sooner.

And I think people want _working_ DRI (graphics) on Linux _and_ *BSD etc. 
sooner than later.

Please do not slowdown DRI development than it even is today.
We have so much _bugs_ even without 6 months cycles...

Every test(er) is welcome.

-Dieter
