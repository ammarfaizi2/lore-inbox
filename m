Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129540AbQK0SSg>; Mon, 27 Nov 2000 13:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129593AbQK0SS0>; Mon, 27 Nov 2000 13:18:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21266 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129540AbQK0SSQ>; Mon, 27 Nov 2000 13:18:16 -0500
Message-ID: <3A229E41.B3C278E2@transmeta.com>
Date: Mon, 27 Nov 2000 09:47:45 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Mandrake Install <install@linux-mandrake.com>
Subject: Re: Universal debug macros.
In-Reply-To: <200011270045.BAA13121@cave.bitwizard.nl>
                <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
                <8vsno2$pc6$1@cesium.transmeta.com> <m3vgt9nykk.fsf@matrix.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chmouel Boudjnah wrote:
> 
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > Something RedHat & co may want to consider doing is providing a basic
> > kernel and have, as part of the install procedure or later, an
> > automatic recompile and install kernel procedure.  It could be
> > automated very easily, and on all but the very slowest of machines, it
> > really doesn't take that long.
> 
> this completely not possible to do in regard of the end-users eyes.
> 

Why not?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
