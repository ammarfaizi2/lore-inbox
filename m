Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135811AbRDTGBz>; Fri, 20 Apr 2001 02:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbRDTGBp>; Fri, 20 Apr 2001 02:01:45 -0400
Received: from s340-modem2058.dial.xs4all.nl ([194.109.168.10]:2696 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S135811AbRDTGBj>;
	Fri, 20 Apr 2001 02:01:39 -0400
Date: Fri, 20 Apr 2001 10:00:31 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Jens Axboe <axboe@suse.de>
cc: <linux-lvm@sistina.com>, <linux-kernel@vger.kernel.org>,
        <linux-openlvm@nl.linux.org>
Subject: Re: [linux-lvm] 2.4.3-ac{6,7} LVM hang
In-Reply-To: <20010419235107.G750@suse.de>
Message-ID: <Pine.LNX.4.31.0104200958360.1043-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jens,

Yes this fixes it.

I'm running 2.4.4-pre4 with only your patch applied.

Greatings,


On Thu, 19 Apr 2001, Jens Axboe wrote:

> On Thu, Apr 19 2001, Arjan Filius wrote:
> > Hello,
> >
> > Same here as reported.
> > restoring lvm.c from 2.4.3 into 2.4.4-pre? "fixes" this. (tested not ac's
> > kernel)
>
> Does attached patch fix it?
>
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

