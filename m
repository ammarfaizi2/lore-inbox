Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRBWNey>; Fri, 23 Feb 2001 08:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129142AbRBWNeo>; Fri, 23 Feb 2001 08:34:44 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:8588 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129137AbRBWNeb>;
	Fri, 23 Feb 2001 08:34:31 -0500
Date: Fri, 23 Feb 2001 14:34:14 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: root <lkthomas@hkicable.com>, linux-kernel@vger.kernel.org
Subject: Re: need to suggest a good FS:
Message-ID: <20010223143414.F5465@khan.acc.umu.se>
In-Reply-To: <3A95A94E.E3C84BE4@hkicable.com> <Pine.LNX.4.33.0102222114340.2548-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0102222114340.2548-100000@asdf.capslock.lan>; from mharris@opensourceadvocate.org on Thu, Feb 22, 2001 at 09:15:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 09:15:45PM -0500, Mike A. Harris wrote:
> On Fri, 23 Feb 2001, root wrote:
> 
> >Date: Fri, 23 Feb 2001 08:05:34 +0800
> >From: root <lkthomas@hkicable.com>
> >To: linux-kernel@vger.kernel.org
> >Content-Type: text/plain; charset=us-ascii
> >Subject: need to suggest a good FS:
> >
> >hey all, trouble again
> >
> >anyone can suggest some good FS that can install linux?
> >exclude reiserfs, ext2, ext3, DOS FAT..etc
> >just need non-normal or non-popular FS, any suggestion?
> 
> cbmfs?  Might be a bit tight on disk space though.  It would
> definitely be non-{normal,popular}.

Hmmm. With additional support for CMD's HD-format for CBMFS, this might
just work. I've got a CMD HD somewhere; maybe I should throw a 1 GB
SCSI-disk into it and get hacking... Would be cool to be able to have
the root file-system on a CBMFS-partition.

Ehrmmmm.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
