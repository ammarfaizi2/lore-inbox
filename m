Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282944AbRK0VTi>; Tue, 27 Nov 2001 16:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282955AbRK0VT2>; Tue, 27 Nov 2001 16:19:28 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:34432 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S282944AbRK0VTR>; Tue, 27 Nov 2001 16:19:17 -0500
Message-ID: <018f01c17789$2cccaac0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Andrew Morton" <akpm@zip.com.au>, "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "Ahmed Masud" <masud@googgun.com>, "'lkml'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home> <000901c17723$b641c990$8604a8c0@googgun.com> <3C03C96D.B3ACA982@zip.com.au>,	<3C03C96D.B3ACA982@zip.com.au> <20011127123128.E9391@mikef-linux.matchmail.com> <3C03FE2F.63D7ACFD@zip.com.au>
Subject: Re: Unresponiveness of 2.4.16
Date: Tue, 27 Nov 2001 22:19:18 +0100
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
From: "Andrew Morton" <akpm@zip.com.au>
To: "Mike Fedyk" <mfedyk@matchmail.com>
Cc: "Ahmed Masud" <masud@googgun.com>; "'lkml'"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, November 27, 2001 9:57 PM
Subject: Re: Unresponiveness of 2.4.16


> Mike Fedyk wrote:
> >
> > >   I'll send you a patch which makes the VM less inclined to page
things
> > >   out in the presence of heavy writes, and which decreases read
> > >   latencies.
> > >
> > Is this patch posted anywhere?
>
> I sent it yesterday, in this thread.  Here it is again.

<snip>

I have made it available at
http://www.cs.umu.se/~c97men/linux/am-response-2.4.16.patch

because I personally like a link or attachment, as that doesn't mess up the
whitespace...(goddamn OE)
I hope you don't mind?

Btw, I'm happily running your patch with
2.4.16 (final)
preempt-kernel-rml-2.4.16-1
ide.2.4.16-p1.11242001

/Martin

