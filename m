Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbQKIN2g>; Thu, 9 Nov 2000 08:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129616AbQKIN21>; Thu, 9 Nov 2000 08:28:27 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:42493 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129230AbQKIN2N>;
	Thu, 9 Nov 2000 08:28:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <00110822033500.04252@dax.joh.cam.ac.uk> 
In-Reply-To: <00110822033500.04252@dax.joh.cam.ac.uk>  <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl> <00110819463200.01915@dax.joh.cam.ac.uk> <3A09B856.EC897A92@mvista.com> 
To: "James A. Sutherland" <jas88@cam.ac.uk>
Cc: George Anzinger <george@mvista.com>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Nov 2000 13:25:50 +0000
Message-ID: <12370.973776350@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jas88@cam.ac.uk said:
>  I think a default whereby the kernel built will run on any
> Linux-capable machine of that architecture would be sensible - so if I
> grab the 2.4.0t10 tarball and build it now, with no changes, I'll be
> able to boot the kernel on any x86 machine.

I have four machines on my desk at the moment. The workstation is a dual 
P-III. I suppose I agree that it might be nice if the kernel for that also 
worked on the embedded 386 board. But it'd also be nice if it worked on the 
Alpha and the SH boards which are also on my desk. How about putting the 
whole lot into a single kernel image? It's the logical extension of what's 
being suggested.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
