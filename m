Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSEaHyX>; Fri, 31 May 2002 03:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSEaHyW>; Fri, 31 May 2002 03:54:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26373
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315198AbSEaHyV>; Fri, 31 May 2002 03:54:21 -0400
Date: Fri, 31 May 2002 00:53:48 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: "David S. Miller" <davem@redhat.com>, mathieu@newview.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre9, IDE on Sparc, Big Disks
In-Reply-To: <Pine.SOL.4.30.0205301424440.2028-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10205310053070.4871-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And offline I suggested using that fix, but I had not tested it.

On Thu, 30 May 2002, Bartlomiej Zolnierkiewicz wrote:

> 
> I fixed this endianness mess some time ago, patch is included in 2.5.x
> but for some reason not in 2.4.x, although Andre was informed about
> problem and send patch ...
> 
> --
> bkz
> 

Andre Hedrick
LAD Storage Consulting Group

