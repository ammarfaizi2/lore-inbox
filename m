Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKXFR0>; Fri, 24 Nov 2000 00:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129632AbQKXFRR>; Fri, 24 Nov 2000 00:17:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24044 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129219AbQKXFRH>;
        Fri, 24 Nov 2000 00:17:07 -0500
Date: Thu, 23 Nov 2000 23:47:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Gregory Maxwell <greg@linuxpower.cx>
cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, bernds@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: gcc 2.95.2 is buggy
In-Reply-To: <20001123233454.B27831@xi.linuxpower.cx>
Message-ID: <Pine.GSO.4.21.0011232344580.12702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Gregory Maxwell wrote:

> On Fri, Nov 24, 2000 at 02:57:45AM +0100, Andries.Brouwer@cwi.nl wrote:
> > but in the meantime there is good confirmation.
> > This really is a bug in gcc 2.95.2.
> 
> ... RedHat's GCC snapshot "2.96" handles this case just fine. 

Now, if you can isolate the relevant part of the diff between 2.95.2 and
RH 2.96...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
