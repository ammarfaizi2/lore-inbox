Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319250AbSIFQDi>; Fri, 6 Sep 2002 12:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319229AbSIFQDi>; Fri, 6 Sep 2002 12:03:38 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:20181 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319250AbSIFQDe>; Fri, 6 Sep 2002 12:03:34 -0400
Date: Fri, 6 Sep 2002 13:07:59 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Woller, Thomas" <tom.woller@cirrus.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: cs4281 & select in 2.4
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C05233F87@csexchange.crystal.cirrus.com>
Message-ID: <Pine.LNX.4.44L.0209061305170.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Woller, Thomas wrote:

> which 2.4 version are you using? 2.4.19?  There was a ham-radio
> select(2) fix in the cs4281 driver back in 2.4.17 era, think that
> it got into the 2.4.18 kernel tree.  I just checked the 2.4.19
> kernel and the fix does seem to be included.

I'm using 2.4.19, but select() doesn't work just as it
didn't in 2.4.16.

> i'll place a tarbz2 file out on an FTP server, and if you can try this
> driver, that would help me out.  if the driver does not build under your
> tree, let me know, it's circa 2.4.17 and i don't know the 2.4.19 mods
> concerning drivers.

> i'll put cs4281-src-20011214-01n-tar.bz2 into \cs4281 directory.

Thanks.  I've just grabbed the tarball and will let you know
if this fixes things.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

