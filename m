Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262484AbSJPMZ7>; Wed, 16 Oct 2002 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPMYO>; Wed, 16 Oct 2002 08:24:14 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:12039 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262484AbSJPMWG>; Wed, 16 Oct 2002 08:22:06 -0400
Date: Wed, 16 Oct 2002 08:27:51 -0400
From: Ben Collins <bcollins@debian.org>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.43
Message-ID: <20021016122751.GM5613@phunnypharm.org>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <20021016073154.GF4827@suse.de> <20021016120528.GI5613@phunnypharm.org> <20021016121842.GA2292@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016121842.GA2292@ncsu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 08:18:42AM -0400, jlnance@unity.ncsu.edu wrote:
> On Wed, Oct 16, 2002 at 08:05:29AM -0400, Ben Collins wrote:
> 
> > > The binary rpms are built on SuSE 8.1, there's a source rpm there too
> > > though. This is 1.11a37 with Linus patch that allows you do to
> > 
> > Can us non-rpm'ers get a tarball, please? Even an upstream tarball with
> > patches in the topdir would be fine.
> 
> Hi Ben,
>     I attached a perl script to this email that will let you turn an rpm
> into a cpio file.  To use it do:
> 
> 	rpm2cpio some.file.rpm | cpio --extract
> 
> Hope this helps.

Thanks. I myself know how to do this :) Just that not everyone uses rpm,
and not everyone knows how to extract things from it.

I don't suspect that the rpm users know that "ar x foo.deb data.tar.gz"
will extract binaries from a .deb either :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
