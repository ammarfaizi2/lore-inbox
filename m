Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbRACLuE>; Wed, 3 Jan 2001 06:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130996AbRACLto>; Wed, 3 Jan 2001 06:49:44 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:19212 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130338AbRACLtm>; Wed, 3 Jan 2001 06:49:42 -0500
Message-ID: <3A530A93.BCB19B0D@Hell.WH8.TU-Dresden.De>
Date: Wed, 03 Jan 2001 12:18:43 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Dan Aloni <karrde@callisto.yi.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <Pine.LNX.4.21.0101031022200.6614-100000@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
> 
> After a bit of few code reviewing, it looks like the only code that
> assigns stuff to ->d_op in a nonstandard way is in fs/vfat/namei.c.
> 
> Udo, are you using vfat?

Yes.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
