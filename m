Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131042AbRBWDfy>; Thu, 22 Feb 2001 22:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbRBWDff>; Thu, 22 Feb 2001 22:35:35 -0500
Received: from dsl-64-192-216-221.telocity.com ([64.192.216.221]:5636 "EHLO
	topgun.unixexchange.com") by vger.kernel.org with ESMTP
	id <S131042AbRBWDfX> convert rfc822-to-8bit; Thu, 22 Feb 2001 22:35:23 -0500
Date: Thu, 22 Feb 2001 22:35:06 -0500 (EST)
From: "Carl D. Speare" <carlds@attglobal.net>
X-X-Sender: <carlds@topgun.unixexchange.com>
To: Quim K Holland <qkholland@my-deja.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: need to suggest a good FS:
In-Reply-To: <200102230127.RAA01303@mail18.bigmailbox.com>
Message-ID: <Pine.BSF.4.33.0102222229370.818-100000@topgun.unixexchange.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HTFS, which is the default filesystem for SCO OpenServer 5, is pretty
rare.

--Carl

On Fri, 23 Feb 2001, Quim K Holland wrote:

> Received: from localhost (localhost.unixexchange.com [127.0.0.1])
> 	by topgun.unixexchange.com (8.11.1/8.11.1) with ESMTP id
>     f1N2h0t00700
> 	for <carlds@localhost>; Thu, 22 Feb 2001 21:43:00 -0500 (EST)
> 	(envelope-from linux-kernel-owner@vger.kernel.org)
> Date: Fri, 23 Feb 2001 01:28:13 +0000 (GMT)
> X-Comment: Sending client does not conform to RFC822 minimum requirements
> X-Comment: Date has been added by Maillennium
> Received: from pop4.prserv.net [32.97.166.5]
> 	by localhost with POP3 (fetchmail-5.5.6)
> 	for carlds@localhost (single-drop); Thu, 22 Feb 2001 21:43:00 -0500 (EST)
> Received: from vger.kernel.org ([199.183.24.194])
>           by prserv.net (in3) with ESMTP
>           id <2001022301281210300smq2ke>; Fri, 23 Feb 2001 01:28:13 +0000
> Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
> 	id <S130461AbRBWB1a>; Thu, 22 Feb 2001 20:27:30 -0500
> Received: (majordomo@vger.kernel.org) by vger.kernel.org
> 	id <S129453AbRBWB1T>; Thu, 22 Feb 2001 20:27:19 -0500
> Received: from mail18.bigmailbox.com ([209.132.220.49]:21518 "EHLO
> 	mail18.bigmailbox.com") by vger.kernel.org with ESMTP
> 	id <S129273AbRBWB1M>; Thu, 22 Feb 2001 20:27:12 -0500
> Received: [ISO-8859-1] ^Üby mail18.bigmailbox.com (8.8.7/8.8.7) id
>     RAA01303;
> 	Thu, 22 Feb 2001 17:27:06 -0800
> Date: Fri, 23 Feb 2001 01:28:13 +0000 (GMT)
> Message-ID: <200102230127.RAA01303@mail18.bigmailbox.com>
> Content-Type: text/plain
> Content-Disposition: inline
> X-Mailer: MIME-tools 4.104 (Entity 4.116)
> Mime-Version: 1.0
> X-Originating-Ip: [198.147.65.9]
> From: Quim K Holland <qkholland@my-deja.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: need to suggest a good FS:
> Sender: linux-kernel-owner@vger.kernel.org
> Precedence: bulk
> X-Mailing-List: 	linux-kernel@vger.kernel.org
> Content-Transfer-Encoding: 8bit
> X-MIME-Autoconverted: from base64 to 8bit by topgun.unixexchange.com id
>     f1N2h0t00700
>
> >>>>> "DW" == David Weinehall <tao@acc.umu.se> writes:
>
> DW> On Thu, Feb 22, 2001 at 07:57:07PM -0500, Wakko Warner wrote:
> >> > anyone can suggest some good FS that can install linux?
> >> > exclude reiserfs, ext2, ext3, DOS FAT..etc
> >> > just need non-normal or non-popular FS, any suggestion?
> >>
> >> How about minixfs?  >=)
>
> DW> ADFS, AFFS, BFS or HPFS are all uncommon
> DW> and unpopular (especially in the case of AFFS, if I understood Alexander
> DW> Viro's woes correctly), QNX4 might do too, then there's always NTFS;
> DW> guaranteed to make your day...
>
> DW> SysV5, UFS and UDF are probably too easy to get going, or?!
>
> tmpfs, swapfs, shmfs :-).
>
>
> ------------------------------------------------------------
> --== Sent via Deja.com ==--
> http://www.deja.com/
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

