Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261974AbREPPEK>; Wed, 16 May 2001 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbREPPEA>; Wed, 16 May 2001 11:04:00 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:62490 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S261974AbREPPDu>; Wed, 16 May 2001 11:03:50 -0400
Message-Id: <200105161505.f4GF5So17570@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Matt Bernstein <mb@dcs.qmw.ac.uk>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.3-XFS 
In-Reply-To: Message from Matt Bernstein <mb@dcs.qmw.ac.uk> 
   of "Wed, 16 May 2001 12:08:46 BST." <Pine.LNX.4.33.0105161159400.2837-100000@nick.dcs.qmw.ac.uk> 
Date: Wed, 16 May 2001 10:05:28 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> [ I'm not subscribed to linux-xfs, please cc me ]
> 
> We have managed to get a Debian potato system (with the 2.4 updates from
> http://people.debian.org/~bunk/debian plus xfs-tools which we imported
> from woody) to run 2.4.3-XFS.
> 
> However, in testing a directory with lots (~177000) of files, we get the
> following oops (copied by hand, and run through ksymoops on a Red Hat box
> since the Debian one segfaulted :( )
> 
> HTH,
> 
> Matt
> 

Can you describe your testing beyond using a directory with 177000 files
in it?

Also, can you explain how you obtained the xfs code, from a patch, from
the cvs development tree, or from somewhere else?

Thanks

   Steve


