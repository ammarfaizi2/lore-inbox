Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275758AbRJNQdO>; Sun, 14 Oct 2001 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275784AbRJNQdA>; Sun, 14 Oct 2001 12:33:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27303 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275758AbRJNQcC>;
	Sun, 14 Oct 2001 12:32:02 -0400
Date: Sun, 14 Oct 2001 12:32:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Ed Tomlinson <tomlins@CAM.ORG>,
        Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
In-Reply-To: <2161290000.1003077041@tiny>
Message-ID: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Chris Mason wrote:

> 
> 
> On Sunday, October 14, 2001 11:55:20 AM -0400 Ed Tomlinson
> <tomlins@CAM.ORG> wrote:
> > 
> > Chris, what I suspect is happening is that the mount with the error leaves
> > the sem locked.  After this any mount commant hangs - not just ones for
> > the USB card read (ie. loop mount to build an initrd fails too..)
> 
> Yup, I see the, I'll send a new patch a little later today.

Cc: it to me, OK?

