Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSGLI20>; Fri, 12 Jul 2002 04:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSGLI2Z>; Fri, 12 Jul 2002 04:28:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:12971 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314451AbSGLI2Y>;
	Fri, 12 Jul 2002 04:28:24 -0400
Message-ID: <003f01c2297e$b3e395d0$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Daniel Phillips" <phillips@arcor.de>,
       "Ville Herva" <vherva@niksula.hut.fi>
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <E17SheA-0002Uh-00@starship> <000901c2296e$7cab2ed0$1c6fa8c0@hyper> <E17Suso-0002dn-00@starship>
Subject: Re: bzip2 support against 2.4.18
Date: Fri, 12 Jul 2002 10:32:47 +0200
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

Daniel wrote on Friday, July 12, 2002:
> On Friday 12 July 2002 08:36, Christian Ludwig wrote:
> > But the question is: who is responsible for all those naming
conventions?
> > Does anyone has an idea?
>
> You are, it's your patch.  And I've taken upon myself the responsibility
> of heaving the decaying vegetables deserved by your first attempt.
>
> Actually, what is the use of even including 'bz2' in the name?  Nobody
> besides we geeks needs to know the thing is compressed with bzip2.  It
> would be nice to see the word 'linux' in there.  How about bzlinux?
> Just think of the hundreds of cases of carpal tunnel syndrome you'd
> prevent by eliminating the shifted character.

First, thanks for your help!
Surely it is better not to have a capital letter. My idea to have that 'bz2'
in the name was that you could also have some more kernel compression
algorithms some day. For all of these you would need new names. To make it
at least a little bit easier there should be that 'bz2' in the name. So
'bz2linux' would be a goal. But if we do this we also could change 'bzImage'
to 'gzlinux'.
On the other hand I also had the idea to let the name 'bzImage' be for both,
gzip and bzip2. The problem is that I can neither overload the name nor
choose the kernel compression at configuration time [I do not know how to
make it at least].

Have fun.

    - Christian


