Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRAHX5U>; Mon, 8 Jan 2001 18:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAHX5F>; Mon, 8 Jan 2001 18:57:05 -0500
Received: from 45-VALL-X13.libre.retevision.es ([62.83.208.45]:10112 "HELO
	lightside.2y.net") by vger.kernel.org with SMTP id <S129752AbRAHX46>;
	Mon, 8 Jan 2001 18:56:58 -0500
Date: Tue, 9 Jan 2001 00:57:07 +0100
From: Ragnar Hojland Espinosa <ragnar@fuckmpaa.com>
To: J Sloan <jjs@toyota.com>
Cc: "Michael D. Crawford" <crawford@goingware.com>,
        linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: [OT]: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Message-ID: <20010109005707.A1347@lightside.2y.net>
In-Reply-To: <3A5A087F.F1C45380@goingware.com> <3A5A4585.5036A11C@toyota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A5A4585.5036A11C@toyota.com>; from J Sloan on Mon, Jan 08, 2001 at 02:56:05PM -0800
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 02:56:05PM -0800, J Sloan wrote:

> In my case, that meant nuking mesa from my system and
> letting Linux use what was left, which got me back the good
> accelerated performance - you may choose a less drastic
> option. I don't see any breakage from the absence of mesa.

Well, the real problem is that (at least Voodoo3) DRI didn't work _before_
with the "latest" test and pre kernels, and X < 4.0.2 (unless there was some
combination I didn't manage to find) even if it was using the correct
library.

[ If anyone would like some help, feel free to email me directly ]
-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
