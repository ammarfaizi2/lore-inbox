Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSLTPph>; Fri, 20 Dec 2002 10:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSLTPph>; Fri, 20 Dec 2002 10:45:37 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:42513 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262528AbSLTPpg>; Fri, 20 Dec 2002 10:45:36 -0500
Date: Fri, 20 Dec 2002 10:50:19 -0500
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Linux 2.4.21-pre2
Message-ID: <20021220155019.GR504@hopper.phunnypharm.org>
References: <Pine.LNX.4.50L.0212181721340.18764-100000@freak.distro.conectiva> <20021220144808.GF27658@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220144808.GF27658@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         -o vmlinux
> ld: cannot open drivers/ieee1394/ieee1394drv.o: No such file or directory
> make: *** [vmlinux] Error 1

I'm not even sure how the hell that change to Makefile got in there.
Probably something we merged for kernel 2.5 before we branched.

Thanks, I'll get it fixed up.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
