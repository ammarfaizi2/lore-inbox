Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318841AbSHQADl>; Fri, 16 Aug 2002 20:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318883AbSHQADl>; Fri, 16 Aug 2002 20:03:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318841AbSHQADk>; Fri, 16 Aug 2002 20:03:40 -0400
Date: Fri, 16 Aug 2002 17:10:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Anton Altaparmakov <aia21@cantab.net>
cc: alan@lxorguk.ukuu.org, <andre@linux-ide.org>, <axboe@suse.de>,
       <vojtech@suse.cz>, <bkz@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE?
In-Reply-To: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Anton Altaparmakov wrote:
> 
> Out of curiosity, who is going to be IDE 2.5 kernel maintainer now?

Well, as I implied, Alan seems to be not completely unwilling to work on 
it, and unlike me he _can_ interact with Andre most of the time. Possibly 
Jens will do the 2.5.x side, of it (with Alan working on 2.4), but we've 
not talked it through.

I'd like Vojtech to be a bit involved too, he seemed to do some
much-needed cleanups for PIIX4 IDE (now gone, since we couldn't save just
those parts..)

		Linus

