Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSGHQlq>; Mon, 8 Jul 2002 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317003AbSGHQlp>; Mon, 8 Jul 2002 12:41:45 -0400
Received: from [62.70.58.70] ([62.70.58.70]:3461 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317002AbSGHQlo> convert rfc822-to-8bit;
	Mon, 8 Jul 2002 12:41:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       <Andries.Brouwer@cwi.nl>
Subject: Re: IDE, util-linux
Date: Mon, 8 Jul 2002 18:43:25 +0200
User-Agent: KMail/1.4.1
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0207081802001.28633-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0207081802001.28633-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207081843.25332.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What patches should I use?
Where are they?

> Don't run vanilla 2.5.25, it has only IDE-93...
>
> On Mon, 8 Jul 2002 Andries.Brouwer@cwi.nl wrote:
> > Yesterday util-linux 2.11t was released.
> > As always, comments are welcome.
> >
> > Wanted to continue some usb-storage work on 2.5 and
> > recklessly booted 2.5.25. It survived for several hours,
> > then deadlocked. Two filesystems turned out to be corrupted.
> > Wouldn't mind if the rock solid 2.4 handling of HPT366
> > was carefully copied to 2.5, that today quickly causes
> > corruption and quickly deadlocks or crashes.
> > [Yes, these are independent bugs. The fact that the current
> > IDE code writes to random disk sectors is much more annoying
> > than the fact that it crashes and deadlocks. This random
> > writing is observed only on disks on the HPT366 card.]
> >
> > Andries
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

