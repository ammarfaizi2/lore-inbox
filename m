Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131878AbRAJAVo>; Tue, 9 Jan 2001 19:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131888AbRAJAVe>; Tue, 9 Jan 2001 19:21:34 -0500
Received: from 108-VALL-X11.libre.retevision.es ([62.83.209.108]:128 "HELO
	lightside.2y.net") by vger.kernel.org with SMTP id <S131785AbRAJAVS>;
	Tue, 9 Jan 2001 19:21:18 -0500
Date: Tue, 9 Jan 2001 17:11:07 +0100
From: Ragnar Hojland Espinosa <ragnar@fuckmpaa.com>
To: J Sloan <jjs@toyota.com>
Cc: "Michael D. Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: [OT]: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Message-ID: <20010109171107.A1470@lightside.2y.net>
In-Reply-To: <3A5A087F.F1C45380@goingware.com> <3A5A4585.5036A11C@toyota.com> <20010109005707.A1347@lightside.2y.net> <3A5A5D4B.7E9D5183@toyota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A5A5D4B.7E9D5183@toyota.com>; from J Sloan on Mon, Jan 08, 2001 at 04:37:32PM -0800
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 04:37:32PM -0800, J Sloan wrote:
> Ragnar Hojland Espinosa wrote:
> > Well, the real problem is that (at least Voodoo3) DRI didn't work _before_
> > with the "latest" test and pre kernels, and X < 4.0.2 (unless there was some
> > combination I didn't manage to find) even if it was using the correct
> > library.

> That's odd, perhaps we should compare notes -

Seeing that it _finally_ worked (that qbert spongies xscreensaver thing is
hilarious:) I cleaned up all the logs, along with the mesas and glides
builds .. so right now all I have is a working setup (which I can't complain
about)

> I have been getting good accelerated 3D from my voodoo3
> since around 2.3.36, except for one brief period around
> 2.3.99-something where some critical kernel code changed.

IIRC I started trying to make it work around 2.3.99 but wasn't as fortunate
as you since as mentioned it just refused to work.
 
> BTW I am using the X server from 3dfx.com -

Ah, that could have something to do with it, because I always used the
(mirrorerd) xfree86.org binaries.
-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
