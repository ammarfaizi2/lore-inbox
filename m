Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbSL0W3i>; Fri, 27 Dec 2002 17:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSL0W3h>; Fri, 27 Dec 2002 17:29:37 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:51686 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265177AbSL0W3h>; Fri, 27 Dec 2002 17:29:37 -0500
Date: Fri, 27 Dec 2002 17:42:27 -0500
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Subject: Re: also frustrated with the framebuffer and your matrox-card in 2.5.53? hack/patch available!
Message-ID: <20021227224227.GA2671@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
> The patch is at
> http://www.xs4all.nl/~thunder7/matroxfb_2553.diff.bz2

Thanks!  Your updated diff works for me too.  Mathijs' timer
warning fix applies to it too:

http://marc.theaimsgroup.com/?l=linux-fbdev-devel&m=103875174429829&w=2

Petr's matroxfb is truely an amazing programming feat.
I use a 3 year old G400 instead of a newer nVidia card
with more memory on my main box because of matroxfb's
vast superiority in text mode.

http://home.earthlink.net/~rwhron/hardware/matrox.html

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html
Linux rushmore 2.5.53-mm1 #1 Fri Dec 27 08:41:11 EST 2002 i686

