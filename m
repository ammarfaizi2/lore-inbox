Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbTALUXX>; Sun, 12 Jan 2003 15:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbTALUXR>; Sun, 12 Jan 2003 15:23:17 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:13829 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267505AbTALUXE>; Sun, 12 Jan 2003 15:23:04 -0500
Date: Sun, 12 Jan 2003 20:31:50 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: make xconfig broken in bk current
Message-ID: <20030112203150.GA53199@compsoc.man.ac.uk>
References: <200301121512.59840.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301121512.59840.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18Xolq-000KXM-00*j/6yatInkdw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 03:12:59PM -0500, Ed Tomlinson wrote:

> > Which distribution do you use?
> > It looks like you try to use a different g++ version than qt was
> > compiled with.
> 
> This makes sense.  Debian has changed its default compiler to 3.2 in
> sid...  Suspect we will get quite a few reports like this one.

Can I just repeat my request to move this Qt stuff entirely out of the
kernel package, where it belongs ?

The current detection doesn't even start to get things working
correctly.

regards
john

-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
