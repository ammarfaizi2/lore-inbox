Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317765AbSGPGma>; Tue, 16 Jul 2002 02:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317766AbSGPGm3>; Tue, 16 Jul 2002 02:42:29 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:55971 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S317765AbSGPGm3>; Tue, 16 Jul 2002 02:42:29 -0400
Message-Id: <5.1.0.14.0.20020716084354.00a1fbc0@legolas.dynup.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 16 Jul 2002 08:46:36 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: Linux 2.4.19-rc1-ac5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D335F04.6070700@zytor.com>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
 <20020715220241Z317668-	 685+9887@vger.kernel.org>
 <agvl00$jjm$1@cesium.transmeta.com>
 <1026779299.32689.46.camel@irongate.swansea.linux.org.uk>
 <3D335903.6000603@zytor.com>
 <1026775760.1093.508.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:47 16-7-02, you wrote:
>Robert Love wrote:
> > On Mon, 2002-07-15 at 16:21, H. Peter Anvin wrote:
> >
> >
> >>Hmmm...
> >>
> >>This bothers me somewhat, because a .bz2 file should not have been
> >>created if the .gz file was corrupt, but the original poster strongly
> >>implied that he had both the .gz file and a .bz2 file, unless your
> >>update came in between.
> >
> >
> > No, I think the bzip2 was not created while the gzip file was corrupt.
> >
> > Earlier, there was a corrupt gzip and no bzip2 file.
> >
> > Then I guess Alan fixed it, and now there exists both a valid gzip and
> > bzip2 file.  So I think your stuff is working fine :)
> >
>
>Right, misunderstanding cleared up.
>
>By the way, these things really should go to the kernel/patch author,
>not to the list.

I thought that by cc'ing the list people would wait with downloading until 
the  problem is fixed. If there is a next time I will only send it to the 
author.

         Rudmer

