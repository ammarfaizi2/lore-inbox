Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293154AbSB1Esi>; Wed, 27 Feb 2002 23:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSB1ErT>; Wed, 27 Feb 2002 23:47:19 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:16132
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S293159AbSB1Eqx>; Wed, 27 Feb 2002 23:46:53 -0500
Date: Wed, 27 Feb 2002 23:48:14 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: 2.4.19-pre1-ac2-xfs-shawn8 released - important
In-Reply-To: <Pine.LNX.4.40.0202272257270.572-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.40.0202272347320.763-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


xfs_utils.c:35: storage size of `xfsstats' isn't known
make[3]: *** [xfs_utils.o] Error 1
make[3]: Leaving directory `/usr/src/linux-xfs-shawn8/fs/xfs'

This is expected, if you compile EXT2/EXT3 with XFS (all). A fix is coming
tomorrow.

Shawn.


On Wed, 27 Feb 2002, Shawn Starr wrote:

>
> xfs-2.4.19-ac2-shawn8   against 2.4.18 vanilla, (Feb 27th, 2002)
>
> Contains:
>
> 2.4.19-pre1                     (Marcelo Tosatti)
> 2.4.19-pre1-ac2                 (Alan Cox)
> 2.4.18-pre3-quotactl            (Jan Kara
>                                  SGI XFS people)
> rmap-12f                        (Rik van Riel
>                                  William Lee Irwin III)
>
> *NOTE: rmap-12g coming and may go into -shawn9 testing 12f still*
>
> Feb 27th, XFS CVS               (me)
> IDE taskfile (newest)           (Andre Hedrick)
>
> Shawn.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

