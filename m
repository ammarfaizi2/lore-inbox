Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbREOWe2>; Tue, 15 May 2001 18:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbREOWeS>; Tue, 15 May 2001 18:34:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:49165 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261665AbREOWd7>; Tue, 15 May 2001 18:33:59 -0400
Message-ID: <3B01AE8B.7789F2A0@transmeta.com>
Date: Tue, 15 May 2001 15:32:43 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <200105152141.f4FLff300686@vindaloo.ras.ucalgary.ca>
		<E14zn4x-0003CZ-00@the-village.bc.nu> <200105152228.f4FMSQw02343@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Even if we have per-device filesystems, we are going to have the same
> issue, in one form or another. If we have a "/devicetype" trailing
> component added on, then somewhere it has to report "CD-ROM" or "cd"
> or "Compact Disc".
> 

Again, many device types aren't mutually exclusive.  It's a set, not an
enum.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
