Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSG2KlY>; Mon, 29 Jul 2002 06:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSG2KlY>; Mon, 29 Jul 2002 06:41:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57512 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314707AbSG2Kky>;
	Mon, 29 Jul 2002 06:40:54 -0400
Date: Mon, 29 Jul 2002 12:44:36 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020729124436.D4861@suse.de>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com> <3D40E62B.9070202@evision.ag> <20020726143840.GC8761@suse.de> <3D416625.4050205@evision.ag> <20020728212523.A3460@suse.de> <3D4517EA.5030305@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4517EA.5030305@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29 2002, Marcin Dalecki wrote:
> Jens Axboe wrote:
> 
> >
> >But the crap still got merged, sigh... Yet again an excellent point of
> >why stuff like this should go through the maintainer. Apparently Linus
> >blindly applies this stuff.
> 
> Jens. Please note that this doesn't make *anything* worser then before,
> since I don't use this function right now.

SCSI does, though :-)

It's ok now, the issue is resolved as far as I'm concerned.

-- 
Jens Axboe

