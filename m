Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130467AbRAWSBq>; Tue, 23 Jan 2001 13:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130844AbRAWSBg>; Tue, 23 Jan 2001 13:01:36 -0500
Received: from 229-VALL-X5.libre.retevision.es ([62.83.215.229]:128 "HELO
	lightside.2y.net") by vger.kernel.org with SMTP id <S130467AbRAWSBY>;
	Tue, 23 Jan 2001 13:01:24 -0500
Date: Tue, 23 Jan 2001 13:43:33 +0100
From: Ragnar Hojland Espinosa <ragnar@fuckmpaa.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: Trever Adams <vichu@digitalme.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
Message-ID: <20010123134333.A1096@lightside.2y.net>
In-Reply-To: <20010115215047Z131660-403+523@vger.kernel.org> <Pine.LNX.4.32.0101230026490.7610-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <Pine.LNX.4.32.0101230026490.7610-100000@asdf.capslock.lan>; from Mike A. Harris on Tue, Jan 23, 2001 at 12:33:45AM -0500
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 12:33:45AM -0500, Mike A. Harris wrote:
> On Mon, 15 Jan 2001, Trever Adams wrote:
> 
> >I had a similar experience.  All I can say is windows 98
> >and ME seem to have it out for Linux drives running late
> >2.3.x and 2.4.0 test and release.  I had windows completely
> >fry my Linux drive and I lost everything.  I had some old
> 
> I don't see how Windows 9x can be at fault in any way shape or
> form, if you can boot between 2.2.x kernel and 9x no problem, but
> lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
> everything.  Windows does not touch your Linux fs's, so if there

WS Windows might reprogram IDE / drives in some way that, being left in that
state, conflict with linux's. .. well, ask Andre, he'll know :)

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
