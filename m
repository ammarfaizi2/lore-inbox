Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265015AbSKAOKP>; Fri, 1 Nov 2002 09:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSKAOKP>; Fri, 1 Nov 2002 09:10:15 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:32526 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265015AbSKAOKL>; Fri, 1 Nov 2002 09:10:11 -0500
Date: Fri, 1 Nov 2002 09:16:32 -0500
From: Ben Collins <bcollins@debian.org>
To: Nikita Shulga <malfet@mipt.sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISOFS question
Message-ID: <20021101141632.GJ1521@phunnypharm.org>
References: <200211020546.10758.malfet@mipt.sw.ru> <20021101130355.GI1521@phunnypharm.org> <200211020913.25675.malfet@mipt.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211020913.25675.malfet@mipt.sw.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 09:13:25AM -0800, Nikita Shulga wrote:
> ? ?????? ?? Friday 01 November 2002 05:03 ?? ????????:
> > Errm, if I know my formats (which I might not) you can't mount a VCD
> > because it is just mpeg written to a track, not ISOFS or any sort of FS
> > at all.
> That's not right! Try mount VCD with iso9660 - you'll se directory structure..
> Or you can look at source code of vcdxrip ...
> Or(the worst case) you can insert your VCD into Windows BOX and browse CD-ROM 
> icon - you'll see several dir's and files
> The problem is(as far as I understand) is that Linux kernel ISOFS can't work 
> properly with 2336 sector sizes
> Best...,
> 	Nikita

That's just the header. AFAIK, the actual data is raw on track two.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
