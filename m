Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSIVKJs>; Sun, 22 Sep 2002 06:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbSIVKJr>; Sun, 22 Sep 2002 06:09:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:32496 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262722AbSIVKJr>;
	Sun, 22 Sep 2002 06:09:47 -0400
Date: Sun, 22 Sep 2002 06:14:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
cc: Aniruddha Shankar <ashankar@nls.ac.in>, linux-kernel@vger.kernel.org
Subject: Re: make bzImage fails on 2.5.38
In-Reply-To: <1032688484.2150.2.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0209220557000.22740-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 Sep 2002, Arjan van de Ven wrote:

> On Sun, 2002-09-22 at 08:31, Alexander Viro wrote:
> > 
> > 
> > On Sun, 22 Sep 2002, Aniruddha Shankar wrote:
> > 
> > > First post to the list, I've followed the format given in REPORTING-BUGS
> > > 
> > > 1. make bzImage fails on 2.5.38
> > 
> > Arrgh.
> > 
> > ed fs/partitions/check.c <<EOF
> > 365s/devfs_handle/cdroms/
> > w
> > q
> > EOF
> 
> using ed now that you can't post vi scripts ?

Hey, exact quote was "don't anybody else try to send patches as vi scripts",
so... ;-)  Seriously, in that case context diff is an overkill.

