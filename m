Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129487AbRBVUNX>; Thu, 22 Feb 2001 15:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbRBVUND>; Thu, 22 Feb 2001 15:13:03 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:14368 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129385AbRBVUMz>; Thu, 22 Feb 2001 15:12:55 -0500
Date: Thu, 22 Feb 2001 14:12:22 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pat Verner <pat@isis.co.za>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Network hanging - Tulip driver with Netgear (Lite-On)
In-Reply-To: <E14VtCQ-0003t2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1010222141134.4774B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Alan Cox wrote:
> > three Netgear NICs and am experiencing considerable trouble with the=20
> > combination:
> > 
> > Kernel 2.4.[01]:        ifconfig shows that the card see's traffic on t=
> > he=20
> > network, but does not transmit anything (no response to ping).
> 
> Use a current 2.4.*-ac. Jeff and co fixed this we think.

Credit almost 100% to Manfred Spraul for isolating the problem, making a
patch, and passing it around for testing... I was just the merge monkey
in this case :)

	Jeff



