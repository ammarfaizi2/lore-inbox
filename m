Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154425AbQC3Xnl>; Thu, 30 Mar 2000 18:43:41 -0500
Received: by vger.rutgers.edu id <S154196AbQC3XbZ>; Thu, 30 Mar 2000 18:31:25 -0500
Received: from smtp1.chello.se ([193.150.195.10]:46210 "EHLO smtp1.chello.se") by vger.rutgers.edu with ESMTP id <S154230AbQC3XVB> convert rfc822-to-8bit; Thu, 30 Mar 2000 18:21:01 -0500
From: Nicholai Benalal <nicholai@chello.se>
To: Alexander Viro <viro@math.psu.edu>, Dave Jones <dave@denial.force9.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux/APUS <linux-apus@sunsite.auc.dk>
Date: Fri, 31 Mar 2000 00:40:53 +0100
Message-ID: <yam8125.2671.1468844368@smtp.chello.se>
In-Reply-To: <Pine.GSO.4.10.10003301742340.25071-100000@weyl.math.psu.edu>
X-Mailer: YAM 2.0 [040] AmigaOS E-Mail Client (c) 1995-1999 by Marcel Beck  http://www.yam.ch
Subject: Re: AFFS fixes v1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

Hello Alexander

Den 31-Mar-00, skrev Alexander Viro:

AV> The bottom line: AFFS design is a festering pile of dung and attempts to
AV> make it look like UNIX filesystem only made it uglier. Judging by
AV> dejanews search, AmigaOS itself doesn't handle it well. Hell knows what
AV> had stopped them from replacing it with decent filesystem - with the
AV> thing outside of kernel it wasn't that hard to do... Damnit, FAT is not
AV> so braindead compared to that abortion.
AV> 

AFFS works allright under AmigaOS. It has limitations but generally it's ok.
Still, a lot of people use other filesystems for AmigaOS but there are no
Linux drivers for these. 

So the best way to transfer files between the Amiga side and Linux is still the 
buggy Linux affs driver :-)


Regards

Nicholai Benalal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
