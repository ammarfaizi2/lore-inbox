Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130676AbRAIAiA>; Mon, 8 Jan 2001 19:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbRAIAhv>; Mon, 8 Jan 2001 19:37:51 -0500
Received: from raven.toyota.com ([63.87.74.200]:57098 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S130070AbRAIAhm>;
	Mon, 8 Jan 2001 19:37:42 -0500
Message-ID: <3A5A5D4B.7E9D5183@toyota.com>
Date: Mon, 08 Jan 2001 16:37:32 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ll i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ragnar Hojland Espinosa <ragnar@fuckmpaa.com>
CC: "Michael D. Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: [OT]: DRI doesn't work on 2.4.0 but does on prerelease-ac5
In-Reply-To: <3A5A087F.F1C45380@goingware.com> <3A5A4585.5036A11C@toyota.com> <20010109005707.A1347@lightside.2y.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ragnar Hojland Espinosa wrote:

> On Mon, Jan 08, 2001 at 02:56:05PM -0800, J Sloan wrote:
>
> > In my case, that meant nuking mesa from my system and
> > letting Linux use what was left, which got me back the good
> > accelerated performance - you may choose a less drastic
> > option. I don't see any breakage from the absence of mesa.
>
> Well, the real problem is that (at least Voodoo3) DRI didn't work _before_
> with the "latest" test and pre kernels, and X < 4.0.2 (unless there was some
> combination I didn't manage to find) even if it was using the correct
> library.

That's odd, perhaps we should compare notes -

I have been getting good accelerated 3D from my voodoo3
since around 2.3.36, except for one brief period around
2.3.99-something where some critical kernel code changed.

I have been using the kernel drm all along.

BTW I am using the X server from 3dfx.com -

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
