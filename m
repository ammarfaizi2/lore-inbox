Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <156037-19607>; Fri, 22 Jan 1999 03:05:19 -0500
Received: by vger.rutgers.edu id <154779-19607>; Fri, 22 Jan 1999 01:25:56 -0500
Received: from electricrain.com ([209.60.85.20]:1591 "HELO electricrain.com" ident: "qmailr") by vger.rutgers.edu with SMTP id <156781-19608>; Fri, 22 Jan 1999 00:01:16 -0500
From: "Numa" <numa@electricrain.com>
Date: Thu, 21 Jan 1999 21:04:17 -0800
To: Riley Williams <rhw@BigFoot.Com>
Cc: Matthew Kirkwood <weejock@ferret.lmh.ox.ac.uk>, Javier Kohan <jkohan@adan.fceia.unr.edu.ar>, linux-kernel@vger.rutgers.edu
Subject: Re: omirr
Message-ID: <19990121210417.A10007@yyz.electricrain.com>
References: <Pine.LNX.3.96.990121192507.31206A-100000@ferret.lmh.ox.ac.uk> <Pine.LNX.3.96.990121200529.28259B-100000@ps.cus.umist.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95i
In-Reply-To: <Pine.LNX.3.96.990121200529.28259B-100000@ps.cus.umist.ac.uk>; from Riley Williams on Thu, Jan 21, 1999 at 08:07:44PM +0000
Sender: owner-linux-kernel@vger.rutgers.edu

Once upon a time Riley Williams shaped the electrons to say...

>  > It went into the kernel at about 2.1.3x and out again at about 5x,
>  > where it became obvious that it was causing too many complications
>  > and was better left to userspace.
> 
> Ah...that makes sense - but did anybody bother writing the relevant
> userland tools?

Something similar to omirr already exists, it has been implemeted in
Irix, and is underway for FreeBSD. The userland tool is called 'webd',
and although the name implies web, it could be used extensively in other
arenas, such as a realtime tripwire. I would dearly love to see the
kernel level stuff ('fmon' under FreeBSD) be ported (in concept at
least) to Linux.. For more information see:

http://science.nas.nasa.gov/Groups/WWW/subpages/topology.html

Or contact me directly.

-D
--
You know, for kids.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
