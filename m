Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbUCTKNI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbUCTKNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:13:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27798 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263305AbUCTKNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:13:05 -0500
Message-ID: <405C191F.3020501@pobox.com>
Date: Sat, 20 Mar 2004 05:12:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
References: <20040319153554.GC2933@suse.de> <200403200140.59543.bzolnier@elka.pw.edu.pl> <405B936C.50200@pobox.com> <200403200224.14055.bzolnier@elka.pw.edu.pl> <20040320095820.GC2711@suse.de>
In-Reply-To: <20040320095820.GC2711@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> I agree with Bart, it's usually never that clear. Quit harping the
> stupid LG issue, they did something brain dead in the firmware and I
> almost have to say that they got what they deserved for doing something
> as _stupid_ as that.

I use it because it's an excellent illustration of what happens when you 
ignore the spec.


> Jeff, it's wonderful to think that you can always rely on checking spec
> bits, but in reality it never really 'just works out' for any given set
> of hardware.

"just issue it and hope" is not a reasonable plan, IMO.

	Jeff



