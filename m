Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQLFWko>; Wed, 6 Dec 2000 17:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLFWke>; Wed, 6 Dec 2000 17:40:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2832 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129627AbQLFWkX>; Wed, 6 Dec 2000 17:40:23 -0500
Message-ID: <3A2EB90A.E5B00B56@transmeta.com>
Date: Wed, 06 Dec 2000 14:09:14 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        rgooch@atnf.csiro.au
Subject: Re: Trashing ext2 with hdparm
In-Reply-To: <Pine.LNX.4.21.0012061521210.83-100000@rc.priv.hereintown.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
> 
> On 6 Dec 2000, H. Peter Anvin wrote:
> 
> > <HARP>
> > Please don't use the path /var/shm... it was a really bad precedent
> > set when someone suggested it.  Use /dev/shm.
> > </HARP>
> 
> And I'll ask again...  If this is now the recommend mount point, can we
> have devfs create this directory for us?
> 

Richard?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
