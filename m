Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281978AbRKUVSt>; Wed, 21 Nov 2001 16:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281979AbRKUVSi>; Wed, 21 Nov 2001 16:18:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8064 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281978AbRKUVS3>; Wed, 21 Nov 2001 16:18:29 -0500
Message-ID: <002b01c172d1$eb9e0e60$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Doug Ledford" <dledford@redhat.com>
Cc: <arjan@fenrus.demon.nl>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs> <3BFBFB4F.8090403@redhat.com> <002101c172c5$f2040cc0$f5976dcf@nwfs> <3BFC10DB.4070705@redhat.com>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Wed, 21 Nov 2001 14:17:26 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Doug Ledford" <dledford@redhat.com>
To: "Jeff Merkey" <jmerkey@timpanogas.org>
Cc: <arjan@fenrus.demon.nl>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 21, 2001 1:38 PM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


> Jeff Merkey wrote:
>
> > Doug,
> >
> > I have seen some problems with the rpm build and default install of your
> > kernel sources.
> > NWFS and the SCI drivers will **NOT** build against it since you post in
a
> > linux and linux-up kernel for lilo during boot.
>
>
> It would if you used my module build kit.
>

Where is this kit?  Is is included in the distribution.  This is way OT,
lets take this discussion off line regarding specific red hat issues.

Jeff

> > People using these drivers
> > who email me always have to do a "make distclean" to get stuff to build.
>
>
> They (and you) think they do, but they don't.
>
> > I
> > am very familiar with the kernel.h
> > changes you guys put in that are different from stock kernels, but
despite
> > this, it's
> > far from "plug and play" for a customer building third party kernel
modules
> > on your rpms.
>
>
>
> See my build kit (which has been available since 6.2 incidentally).
> Very plug and play for a kernel developer.
>
>
>
>
>
>
> --
>
>   Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>        Please check my web site for aic7xxx updates/answers before
>                        e-mailing me about problems

