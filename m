Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBGRNz>; Wed, 7 Feb 2001 12:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBGRNp>; Wed, 7 Feb 2001 12:13:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:10756 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129031AbRBGRNi>; Wed, 7 Feb 2001 12:13:38 -0500
Date: Wed, 7 Feb 2001 11:08:52 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207110852.A27089@vger.timpanogas.org>
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org> <20010206190624.C23960@vger.timpanogas.org> <20010206210731.E1110@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010206210731.E1110@xi.linuxpower.cx>; from greg@linuxpower.cx on Tue, Feb 06, 2001 at 09:07:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 09:07:31PM -0500, Gregory Maxwell wrote:

> So.. It's likely that calling your performance issues 'gcc bugs' is about
> the same as saying that SGI cc is buggy because it can't compile the kernel.
> 
> At least you managed to avoid calling RedHat names. :)

I really have no idea why gcc 2.96 is so troublesome, but for a 
commercial release I was somewhat surprised to see the problems 
I did.  I have heard about some of these problems for quite a 
while, but got a chance to see them upclose with the 7.1 
release.  Hopefully, RedHat will eventually get the issues 
smoothed out.  

Not supporting #ident for CVS managed code bases would see to 
me, at first glance, to be a show stopper to shipping a release 
of anything, since many folks need CVS support.

:-)

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
