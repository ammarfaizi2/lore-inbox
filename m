Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316327AbSEVRgx>; Wed, 22 May 2002 13:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316330AbSEVRgw>; Wed, 22 May 2002 13:36:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33762 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316327AbSEVRgu>;
	Wed, 22 May 2002 13:36:50 -0400
Date: Wed, 22 May 2002 13:36:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Russell King <rmk@arm.linux.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <20020522183012.J16934@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0205221335050.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Russell King wrote:

> > int main(char *argv[], int argc)

> 1. not checking number of arguments passed.
> 2. thinking argv[0] is the first arg.

Sod that; thinking that _argv_ is the first argument of main(). ;-)

