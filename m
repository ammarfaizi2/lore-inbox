Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263318AbUCTKTl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263321AbUCTKTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:19:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58341 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263318AbUCTKTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:19:34 -0500
Date: Sat, 20 Mar 2004 11:19:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320101929.GF2711@suse.de>
References: <20040319153554.GC2933@suse.de> <200403200140.59543.bzolnier@elka.pw.edu.pl> <405B936C.50200@pobox.com> <200403200224.14055.bzolnier@elka.pw.edu.pl> <20040320095820.GC2711@suse.de> <405C191F.3020501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405C191F.3020501@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >I agree with Bart, it's usually never that clear. Quit harping the
> >stupid LG issue, they did something brain dead in the firmware and I
> >almost have to say that they got what they deserved for doing something
> >as _stupid_ as that.
> 
> I use it because it's an excellent illustration of what happens when you 
> ignore the spec.

Really, I think it's a much better demonstration of exactly how stupid
hardware developers are at times...

> >Jeff, it's wonderful to think that you can always rely on checking spec
> >bits, but in reality it never really 'just works out' for any given set
> >of hardware.
> 
> "just issue it and hope" is not a reasonable plan, IMO.

I agree with that as well. I just didn't agree with your rosy idea of
thinking everything would always work if you just check the bits
according to spec.

-- 
Jens Axboe

