Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289487AbSAOPrw>; Tue, 15 Jan 2002 10:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289490AbSAOPrm>; Tue, 15 Jan 2002 10:47:42 -0500
Received: from mx.fluke.com ([129.196.128.53]:19727 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S289487AbSAOPr2>; Tue, 15 Jan 2002 10:47:28 -0500
Date: Tue, 15 Jan 2002 07:47:37 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2 / IDE cdrom_read_intr: data underrun / end_request: I/O
 error
In-Reply-To: <20020115101951.A31257@suse.de>
Message-ID: <Pine.LNX.4.33.0201150744420.767-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 at 10:19 +0100, Jens Axboe <axboe@suse.de> wrote:

> On Mon, Jan 14 2002, David Dyck wrote:
> >
> > I'm still getting data underrun errors using 2.5.2
> > that don't occur using 2.4.18-pre3.
>
> I'll check up on that, mind checking when this happened exactly in the
> 2.5 series?

I know it fails in 2.5.1, and 2.5.2
 (do you need more resolution -- the problem is that many of these
early kernels don't shut down well on my computer, so I end up
fsck'ing after restart.  (I guess this should encourage me to
convert to ext3 :-)

I'd be willing to try a couple other ones if you have
specific -pre patches you'd like resolution on.

