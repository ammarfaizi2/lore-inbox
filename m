Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSASPpy>; Sat, 19 Jan 2002 10:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSASPpo>; Sat, 19 Jan 2002 10:45:44 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23827 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284933AbSASPpb>;
	Sat, 19 Jan 2002 10:45:31 -0500
Date: Sat, 19 Jan 2002 16:45:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020119164503.H27835@suse.de>
In-Reply-To: <20020119124017.G27835@suse.de> <Pine.LNX.4.10.10201190337010.7770-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201190337010.7770-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19 2002, Andre Hedrick wrote:
> On Sat, 19 Jan 2002, Jens Axboe wrote:
> 
> > On Fri, Jan 18 2002, Davide Libenzi wrote:
> > > Guys, instead of requiring an -m8 to every user that is observing this
> > > problem, isn't it better that you limit it inside the driver until things
> > > gets fixed ?
> > 
> > There is no -m8 limit, 2.5.3-pre1 + ata253p1-2 patch handles any set
> > multi mode value.
> > 
> > -- 
> > Jens Axboe
> > 
> 
> And that will generate the [lost interrupt], and I have it fixed at all
> levels too now.

How so? I don't see the problem.

-- 
Jens Axboe

