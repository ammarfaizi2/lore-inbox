Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131391AbRACMlp>; Wed, 3 Jan 2001 07:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131399AbRACMlf>; Wed, 3 Jan 2001 07:41:35 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:55308 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131391AbRACMlV>; Wed, 3 Jan 2001 07:41:21 -0500
Message-ID: <3A531634.38E07DA9@Hell.WH8.TU-Dresden.De>
Date: Wed, 03 Jan 2001 13:08:20 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Dan Aloni <karrde@callisto.yi.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <Pine.GSO.4.21.0101030657120.15658-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alexander Viro wrote:
>
> In principle, it might be that d_find_alias() is broken. I don't see where
> it could happen, but then I'm half-asleep right now...  While we are at it,
> do you have

>         * autofs

Yes.

>         * knfsd
>         * ncpfs

No, neither of these two.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
