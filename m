Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131199AbQKGLOL>; Tue, 7 Nov 2000 06:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbQKGLOC>; Tue, 7 Nov 2000 06:14:02 -0500
Received: from madjfppp.jazztel.es ([212.106.228.133]:20096 "EHLO looping.es")
	by vger.kernel.org with ESMTP id <S131199AbQKGLNn>;
	Tue, 7 Nov 2000 06:13:43 -0500
Date: Tue, 7 Nov 2000 11:22:37 +0100
From: Ragnar Hojland Espinosa <ragnar_hojland@eresmas.com>
To: warp@whitestar.soark.net
Cc: Ragnar Hojland Espinosa <ragnar@jazzfree.com>,
        linux-kernel@vger.kernel.org, "M.H.VanLeeuwen" <vanl@megsinet.net>,
        "CRADOCK, Christopher" <cradockc@oup.co.uk>
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001107112237.A876@macula.net>
In-Reply-To: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk> <3A00B8E9.D5FD12B0@megsinet.net> <20001102185706.A984@macula.net> <20001102193856.A1204@macula.net> <20001103012510.A22193@whitestar.soark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <20001103012510.A22193@whitestar.soark.net>; from kernel@whitestar.soark.net on Fri, Nov 03, 2000 at 01:25:10AM -0500
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 01:25:10AM -0500, kernel@whitestar.soark.net wrote:
> > Just happened with test10, same circumstances .. font map got corrupted, and
> > noise on the screen.  Switching back and forth from X to a vc fixed it, tho. 
> > 
> > Sort of amusing that it (apparently) only happens with ppp + wget ..
> 
> You have a voodoo3 or voodoo5 with X4, and the DRI X4 module loaded.
> 
> Or am I wrong?

v3.. bingo :)

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com

Handle via comment channels only.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
