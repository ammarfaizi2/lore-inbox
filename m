Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRBKOI1>; Sun, 11 Feb 2001 09:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRBKOIS>; Sun, 11 Feb 2001 09:08:18 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:36876 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129415AbRBKOH7>;
	Sun, 11 Feb 2001 09:07:59 -0500
Date: Sun, 11 Feb 2001 15:07:21 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Message-ID: <20010211150721.C17129@almesberger.net>
In-Reply-To: <20010208004021.D189@bug.ucw.cz> <Pine.LNX.4.33.0102080736190.5431-100000@asdf.capslock.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0102080736190.5431-100000@asdf.capslock.lan>; from mharris@opensourceadvocate.org on Thu, Feb 08, 2001 at 07:37:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike A. Harris wrote:
> On Thu, 8 Feb 2001, Pavel Machek wrote:
>> wondering when linux boot gets so long that mpeg2 player gets
>> integrated into kernel.
> 
> ;o)
> 
> I doubt strongly that that is technically possible. In fact I'm
> sure it is not.

Why not ? Just preload the movie with the kernel, and you can start
playing as soon as framebuffer, timers, and interrupts are
available.

Of course, if the word gets out that you're writing such a patch,
the people from the village may come with torches ... ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
