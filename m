Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281080AbRKDSiO>; Sun, 4 Nov 2001 13:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281130AbRKDShR>; Sun, 4 Nov 2001 13:37:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:47076 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281103AbRKDSfr>;
	Sun, 4 Nov 2001 13:35:47 -0500
Date: Sun, 4 Nov 2001 13:35:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tim Jansen <tim@tjansen.de>
cc: Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <160RwJ-2D3EHoC@fmrl05.sul.t-online.com>
Message-ID: <Pine.GSO.4.21.0111041331180.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Tim Jansen wrote:

> On Sunday 04 November 2001 18:41, you wrote:
> > The "fuzzy parsing" userland has to do today to get useful information
> > out of many proc files today is not nice at all. 
> 
> I agree, but you dont need a binary format to achieve this. A WELL-DEFINED 
> format is sufficient. XML is one of them, one-value-files another one. The 

And thinking before defining an API is the third.  Guess why XML is so
popular alternative...

