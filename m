Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRLOBJE>; Fri, 14 Dec 2001 20:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281217AbRLOBIz>; Fri, 14 Dec 2001 20:08:55 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:39099 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S281059AbRLOBIv>; Fri, 14 Dec 2001 20:08:51 -0500
Date: Sat, 15 Dec 2001 01:54:50 +0100 (CET)
From: eduard.epi@t-online.de (Peter Bornemann)
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Peter Bornemann <eduard.epi@t-online.de>, Jens Axboe <axboe@suse.de>,
        Kirk Alexander <kirkalx@yahoo.co.nz>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <20011214210728.K2427-100000@gerard>
Message-ID: <Pine.LNX.4.33.0112150136390.5849-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:

>
>
> On Fri, 14 Dec 2001, Peter Bornemann wrote:
> > Ahemm -- well,
> > maybe I'm the first one. I have a symbios card, which is recognized by
> > lspci:  SCSI storage controller: LSI Logic Corp. / Symbios Logic Inc.
> > (formerly NCR) 53c810 (rev 23).
> Could you, please,  report me more accurate information.
> TIA,
>

Well, it seems I made my intention not very clear: I do not want You to
fix something in the driver, I just wanted from You to leave the old
ncr-driver in the kernel, just for the situation of a first install. I
think no newbie with little knowledge will be able to install Linux (or,
maybe, FreeBSD), when he happens to own such an controller. First, he
won't be able to read very much on the screen, for the loop runs much too
fast and second, he will not understand when he reads something about a
sym53c8xx. Exactly for this case I think the old driver should be left in.
If You want, You can tell him "Attention! Use of this driver deprecated.
Contact Your support." or whatever seems appropriate. It is just about the
first step to linuxland :-)

Hope I managed to make myself clear tris time

Peter B



          .         .
          |\_-^^^-_/|
          / (|)_(|) \
         ( === X === )
          \  ._|_.  /
           ^-_   _-^
              °°°

