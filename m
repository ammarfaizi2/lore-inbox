Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262743AbSI2Pi0>; Sun, 29 Sep 2002 11:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbSI2Pi0>; Sun, 29 Sep 2002 11:38:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6596 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262743AbSI2PiZ>;
	Sun, 29 Sep 2002 11:38:25 -0400
Date: Sun, 29 Sep 2002 17:42:54 +0200
From: Jens Axboe <axboe@suse.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929154254.GD1014@suse.de>
References: <200209290114.15994.jdickens@ameritech.net> <Pine.LNX.4.44.0209290858170.22404-100000@innerfire.net> <20020929134620.GD2153@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929134620.GD2153@gallifrey>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29 2002, Dr. David Alan Gilbert wrote:
> 
> In my case I gave 2.5.x an attempt at building on my x86 box a few weeks
> ago but had to give up because of the lack of LVM which I rely on.

This is a good point. Noone has cared enough about LVM to work on it,
looking at the code in the kernel I cannot blame them. Sistina have
abandoned 2.5 LVM.

Has anyone actually sent patches to Linus removing LVM completely from
2.5 and adding the LVM2 device mapper? If I used LVM, I would have done
exactly that long ago. Linus, what's your oppinion on this?

-- 
Jens Axboe

