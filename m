Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292967AbSB1Byg>; Wed, 27 Feb 2002 20:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293123AbSB1Bxu>; Wed, 27 Feb 2002 20:53:50 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:17926
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S293126AbSB1Bxj>; Wed, 27 Feb 2002 20:53:39 -0500
Date: Wed, 27 Feb 2002 20:54:58 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCEMENT: 2.4.19-pre1-ac1-xfs-shawn7 released - more
In-Reply-To: <Pine.LNX.4.40.0202272049280.9522-100000@coredump.sh0n.net>
Message-ID: <Pine.LNX.4.40.0202272054040.9522-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You will find the patch a little broken with asm symlink, ignore these and
CREDITS.

Shawn.

On Wed, 27 Feb 2002, Shawn Starr wrote:

>
> Some people have tested and have booted successfully. There is one compile
> error in fs/xfs/xfs_utils.c uncomment: struct xfsstats xfsstats if the
> compile bombs. (fixed in -shawn8 coming tonight)
>
> xfs-2.4.19-ac1-shawn7   against 2.4.18 vanilla. (Feb 26th, 2002)
>
> Contains:
>
> 2.4.19-pre1                     (Marcelo Tosatti)
> 2.4.19-pre1-ac1                 (Alan Cox)
> 2.4.18-pre3-quotactl            (Jan Kara
>                                  SGI XFS people)
>
> rmap-12f                        (Rik van Riel
>                                  William Lee Irwin III)
>
> Feb 26th, XFS CVS               (me)
> IDE taskfile IO                 (Andre Hedrick in -ac1)
> (kludge mode)
>
> *NOTE: Quota appears to be fixed (finally). But I need more people to
> confirm.
>
> -shawn8 will have some more changes (see ChangeLog on site).
>
>
> should -shawn8 work, I will begin the merge of -mjc.
>
> Shawn.
>
>
>

