Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbSI3AfV>; Sun, 29 Sep 2002 20:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbSI3AfV>; Sun, 29 Sep 2002 20:35:21 -0400
Received: from mx15.sac.fedex.com ([199.81.197.54]:29198 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261860AbSI3AfU>; Sun, 29 Sep 2002 20:35:20 -0400
Date: Mon, 30 Sep 2002 08:39:28 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
In-Reply-To: <1033316509.13001.23.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209300834410.2804-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 08:40:33 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 08:40:38 AM,
	Serialize complete at 09/30/2002 08:40:38 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Sep 2002, Alan Cox wrote:

> On Sun, 2002-09-29 at 16:42, Jens Axboe wrote:
> > Has anyone actually sent patches to Linus removing LVM completely from
> > 2.5 and adding the LVM2 device mapper? If I used LVM, I would have done
> > exactly that long ago. Linus, what's your oppinion on this?
>
> I added LVM2 a while ago for my 2.4-ac tree and haven't looked back, its
> much nicer code and its clean and easy to understand. I wouldnt
> guarantee its bug free but its the kind of code where you can *find* a
> bug if one turns up

I can't even get past "make apply-patches" with device-mapper.0.96.04 on
2.5.39.

Anyone running lvm2 on 2.5.3x ?

Thanks,
Jeff


