Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWEUS4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWEUS4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWEUS4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:56:34 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:7601 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S964910AbWEUS4d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:56:33 -0400
Subject: Re: Linux Kernel Source Compression
From: Kasper Sandberg <lkml@metanurb.dk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
In-Reply-To: <Pine.LNX.4.61.0605212026570.6083@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0605211028100.4037@p34>
	 <Pine.LNX.4.61.0605212026570.6083@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sun, 21 May 2006 20:56:17 +0200
Message-Id: <1148237777.28518.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 20:40 +0200, Jan Engelhardt wrote:
> >
> > Was curious as to which utilities would offer the best compression ratio for
> > the kernel source, I thought it'd be bzip2 or rar but lzma wins, roughly 6 MiB
> > smaller than bzip2.
> >
> You forgot:
>   - .7z    7zip
>   - .j     JAR (www.arjsoftware.com)
>   - .ice   LHICE (some sort of "brother" to lharc aka lzh)
>   - .ace   ACE (www.winace.com)
>   -        UPX (yes!, you just need to put '#!/\n' at the front)
>   - .cab   MS CAB (use winace)
>   - .bh    BlackHole
>   - .pak   PKARC 2.51
>   - .sqz   SqueezeIt
>   - "LZEXE"
and also lzx, which was, in the amige days the best there was, allthough
i know of no compressor for linux

> 
> ftp://camelot.spsl.nsc.ru/pub/win32/arc/ - you'll find some there
> happy packing :)
> 
> > 38064   linux-2.6.16.17.tar.rz
> 
>   - is this rzip with _maximum_ distance?
> 
> 
> Jan Engelhardt

