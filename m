Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131605AbQKYSsa>; Sat, 25 Nov 2000 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131600AbQKYSsU>; Sat, 25 Nov 2000 13:48:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:58382 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131430AbQKYSsL>; Sat, 25 Nov 2000 13:48:11 -0500
Date: Sat, 25 Nov 2000 12:14:54 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.2.18-23 as pppd dial in server
Message-ID: <20001125121454.D29510@vger.timpanogas.org>
In-Reply-To: <3A1EF9A5.2E335F0C@timpanogas.org> <m37l5s2cge.fsf@matrix.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <m37l5s2cge.fsf@matrix.mandrakesoft.com>; from chmouel@mandrakesoft.com on Sat, Nov 25, 2000 at 06:22:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 06:22:57PM +0100, Chmouel Boudjnah wrote:
> "Jeff V. Merkey" <jmerkey@timpanogas.org> writes:
> 
> > Was able to reproduce this Oops, but it took several days.   Oops occurs
> > against 2.2.18-23.  I had to copy this info from the console -- the
> > system was hard hung after the oops and even ksymoops was locked solid.
> 
> what type of mounted filesystem you have (dos/ext2) ?

ext2/nwfs.  I made the mitake of rebuilding the kernel so I have
to recompile again to get the System.map file to ksymoops the 
crash.   I will try to have it completed today and posted.

Jeff

> 
> -- 
> MandrakeSoft Inc                     http://www.chmouel.org
>                       --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
