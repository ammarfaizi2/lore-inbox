Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTHFKG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270696AbTHFKG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:06:56 -0400
Received: from mathematik.uni-freiburg.de ([132.230.2.117]:29830 "EHLO
	uni-freiburg.de") by vger.kernel.org with ESMTP id S270695AbTHFKGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:06:55 -0400
Message-ID: <3F30D33C.3010904@mathematik.uni-freiburg.de>
Date: Wed, 06 Aug 2003 12:06:52 +0200
From: Claus-Justus Heine <claus@mathematik.uni-freiburg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030312
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Adrian Bunk <bunk@fs.tum.de>, heine@instmath.rwth-aachen.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
References: <200308051242.h75CgSj6028203@harpo.it.uu.se> <20030805130324.GC16091@fs.tum.de> <16175.45710.993756.301205@gargle.gargle.HOWL> <20030805134823.GD16091@fs.tum.de> <16175.47282.627835.2678@gargle.gargle.HOWL>
In-Reply-To: <16175.47282.627835.2678@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mikael Pettersson schrieb:
> Adrian Bunk writes:
>  > On Tue, Aug 05, 2003 at 03:35:10PM +0200, Mikael Pettersson wrote:
>  > > 
>  > > ftape-4.04? That's been a non-integrated external package for ages and ages.
>  > > I doubt there's been any updates in it for 2.5/2.6 kernels.
>  > >...
>  > 
>  > Is there a good reason why it wasn't / isn't integrated?
> 
> Claus-Justus (the official maintainer) never bothered doing it.

I gave up trying to update the in-kernel ftape version because I my updates 
didn't come through (that was before the 2.2 and again before the 2.4 kernels 
were released). There are more pleasant wastes of time than to try to go 
through a one-man super-maintainer's eye of a needle.

Actually, the in-kernel version of ftape should be replaced or deleted, it is 
damn outdated anyway and buggy.

In principle, there were some attempts to elect a new ftape-maintainer some 
time ago (Roby Basak, if I remember right).

I could provide a kernel patch for 2.4 and 2.6 to update the in-kernel version 
of ftape if that is wanted.

Otherwise I'd suggest to remove me from the maintainer's list and/or delete 
ftape from the kernel source tree.

Greetings

Claus

--
    Dipl.-Math. Claus-Justus Heine
    Institute for Applied Mathematics              Phone: +49-761-203-5647
    Hermann-Herder-Str. 10                         Fax: +49-761-203-5632
    Freiburg University
    79104 Freiburg / Brsg., Germany

