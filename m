Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWEUT2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWEUT2a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWEUT2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:28:30 -0400
Received: from lucidpixels.com ([66.45.37.187]:14039 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964923AbWEUT2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:28:30 -0400
Date: Sun, 21 May 2006 15:28:28 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <Pine.LNX.4.61.0605212026570.6083@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0605211528010.25580@p34>
References: <Pine.LNX.4.64.0605211028100.4037@p34>
 <Pine.LNX.4.61.0605212026570.6083@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compressed with -9.

      -9            slowest (best) compression

Unsure on the maximum distance.

Version info:

rzip 2.1
Copright (C) Andrew Tridgell 1998-2003


On Sun, 21 May 2006, Jan Engelhardt wrote:

>>
>> Was curious as to which utilities would offer the best compression ratio for
>> the kernel source, I thought it'd be bzip2 or rar but lzma wins, roughly 6 MiB
>> smaller than bzip2.
>>
> You forgot:
>  - .7z    7zip
>  - .j     JAR (www.arjsoftware.com)
>  - .ice   LHICE (some sort of "brother" to lharc aka lzh)
>  - .ace   ACE (www.winace.com)
>  -        UPX (yes!, you just need to put '#!/\n' at the front)
>  - .cab   MS CAB (use winace)
>  - .bh    BlackHole
>  - .pak   PKARC 2.51
>  - .sqz   SqueezeIt
>  - "LZEXE"
>
> ftp://camelot.spsl.nsc.ru/pub/win32/arc/ - you'll find some there
> happy packing :)
>
>> 38064   linux-2.6.16.17.tar.rz
>
>  - is this rzip with _maximum_ distance?
>
>
> Jan Engelhardt
> -- 
>
