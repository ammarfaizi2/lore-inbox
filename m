Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273364AbRJNCCF>; Sat, 13 Oct 2001 22:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273831AbRJNCBu>; Sat, 13 Oct 2001 22:01:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13266 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273364AbRJNCBd>;
	Sat, 13 Oct 2001 22:01:33 -0400
Date: Sat, 13 Oct 2001 22:02:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Tomlinson <tomlins@CAM.ORG>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
In-Reply-To: <20011014015115.E894D11718@oscar.casa.dyndns.org>
Message-ID: <Pine.GSO.4.21.0110132201150.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Ed Tomlinson wrote:

> 
> >On Sun, 14 Oct 2001, Riley Williams wrote:
> 
> >> He said in his original email that it was a USB SmartMedia reader,
> >> which reads the SmartMedia cards used with FujiFilm digital cameras
> >> (amongst others). The actual file system is determined by the cards
> >> themselves and can't be changed.
> 
> >Ahem.  Which fs driver is used when it's successfully mounted?
> 
> fat.  Would an strace help?

It might, but another thing I'd like to see is stack trace of hung mount.

