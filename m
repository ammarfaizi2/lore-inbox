Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160024-27300>; Sun, 31 Jan 1999 02:03:04 -0500
Received: by vger.rutgers.edu id <157685-27300>; Sun, 31 Jan 1999 02:02:46 -0500
Received: from z.ml.org ([209.208.36.5]:18436 "EHLO z.ml.org" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157656-27300>; Sun, 31 Jan 1999 02:02:18 -0500
Date: Sun, 31 Jan 1999 02:15:34 -0500 (EST)
From: Gregory Maxwell <linker@z.ml.org>
To: Simon Weijgers <simon@mbit.doa.org>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: CMI-8338/Pci SoundPro
In-Reply-To: <Pine.LNX.3.96.990131014324.9691o-100000@mbit.doa.org>
Message-ID: <Pine.LNX.3.96.990131021440.3976B-100000@z.ml.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


Thanks!

Have you looked into getting specs for the native mode?

The dos trick is nice, but it wont work for me in the long run, as
ultmatly I want to use these cards in systems that boot off
disk-on-a-chip. :)

On Sun, 31 Jan 1999, Simon Weijgers wrote:

> > 
> > Is there currently any work on supporting the CMI8338 PCI sound chip?
> > 
> Booting through dos works for me. Just load the dos drivers and loadlin
> and insmod normal soundblaster drivers and you are ok.
> 
> Regards,
> 
> Simon Weijgers
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
