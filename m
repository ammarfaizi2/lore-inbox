Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbSBBX3c>; Sat, 2 Feb 2002 18:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSBBX3W>; Sat, 2 Feb 2002 18:29:22 -0500
Received: from brick.kernel.dk ([195.249.94.204]:16025 "EHLO
	burns.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S276424AbSBBX3G>; Sat, 2 Feb 2002 18:29:06 -0500
Date: Sun, 3 Feb 2002 00:28:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: "Axel H. Siebenwirth" <axel@hh59.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Message-ID: <20020203002821.A29553@suse.de>
In-Reply-To: <20020202102659.L12156@suse.de> <Pine.LNX.4.10.10202021158010.26613-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202021158010.26613-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02 2002, Andre Hedrick wrote:
> 
> Jens,
> 
> You and I know Linus will go ballistic over the reintroduction of a
> working copy model using rq scratch pad.  We can go with this return to

No I don't think so, I'd be surprised if Linus cared about that at all.

> what we are trying to get away from but we really need a way to stream the
> pointers to the data register cleanly.  Otherwise the benefits of the zero
> copy in block go away.

?? Your point is not clear. zero copy what, request struct?! That would
be way below measurable.

-- 
Jens Axboe

