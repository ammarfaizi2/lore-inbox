Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZBu0>; Thu, 25 Jan 2001 20:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129395AbRAZBuP>; Thu, 25 Jan 2001 20:50:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16391 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129169AbRAZBuC>; Thu, 25 Jan 2001 20:50:02 -0500
Message-ID: <3A70D7B2.F8C5F67C@transmeta.com>
Date: Thu, 25 Jan 2001 17:49:38 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
		<94qcvm$9qp$1@cesium.transmeta.com>
		<14960.54069.369317.517425@pizda.ninka.net>
		<3A70D524.11362EFB@transmeta.com> <14960.54852.630103.360704@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> H. Peter Anvin writes:
>  > Last I communicated with them, I looked for a reference like that in the
>  > standards RFCs so I could quote chapter and verse at the Hotmail people,
>  > but I couldn't find it.
> 
> RFC793, where is lists the unused flag bits as "reserved".
> That is pretty clear to me.  It just has to say that
> they are reserved, and that is what it does.
> 

Is the definition of "reserved" defined anywhere?  In a lot of specs,
"reserved" means MBZ.

Note, that I'm not arguing with you.  I'm trying to pick this apart.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
