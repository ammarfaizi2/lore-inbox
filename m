Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261885AbSI3BAp>; Sun, 29 Sep 2002 21:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261878AbSI3BAW>; Sun, 29 Sep 2002 21:00:22 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:31754 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261884AbSI3A7N>; Sun, 29 Sep 2002 20:59:13 -0400
Date: Mon, 30 Sep 2002 09:03:29 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0 (fwd)
Message-ID: <Pine.LNX.4.44.0209300902160.13457-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 09:04:31 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/30/2002
 09:04:33 AM,
	Serialize complete at 09/30/2002 09:04:33 AM
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



