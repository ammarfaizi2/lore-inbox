Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154193AbQC3X5e>; Thu, 30 Mar 2000 18:57:34 -0500
Received: by vger.rutgers.edu id <S154268AbQC3Xx1>; Thu, 30 Mar 2000 18:53:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:52258 "EHLO math.psu.edu") by vger.rutgers.edu with ESMTP id <S154456AbQC3Xrw>; Thu, 30 Mar 2000 18:47:52 -0500
Date: Thu, 30 Mar 2000 18:51:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nicholai Benalal <nicholai@chello.se>
Cc: Dave Jones <dave@denial.force9.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux/APUS <linux-apus@sunsite.auc.dk>
Subject: Re: AFFS fixes v1
In-Reply-To: <yam8125.2671.1468844368@smtp.chello.se>
Message-ID: <Pine.GSO.4.10.10003301848440.25071-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Fri, 31 Mar 2000, Nicholai Benalal wrote:

> Hello Alexander
> 
> Den 31-Mar-00, skrev Alexander Viro:
> 
> AV> The bottom line: AFFS design is a festering pile of dung and attempts to
> AV> make it look like UNIX filesystem only made it uglier. Judging by
> AV> dejanews search, AmigaOS itself doesn't handle it well. Hell knows what
> AV> had stopped them from replacing it with decent filesystem - with the
> AV> thing outside of kernel it wasn't that hard to do... Damnit, FAT is not
> AV> so braindead compared to that abortion.
> AV> 
> 
> AFFS works allright under AmigaOS. It has limitations but generally it's ok.

Search for comp.sys.amiga.* & link* & director* & FFS

> So the best way to transfer files between the Amiga side and Linux is still the 
> buggy Linux affs driver :-)

Hrrrmmm... I surely hope that somebody _had_ ported tar to AmigaOS, right?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
