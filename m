Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282781AbRLBG03>; Sun, 2 Dec 2001 01:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282783AbRLBG0T>; Sun, 2 Dec 2001 01:26:19 -0500
Received: from adsl-63-193-243-214.dsl.snfc21.pacbell.net ([63.193.243.214]:36224
	"EHLO dmz.ruault.com") by vger.kernel.org with ESMTP
	id <S282781AbRLBG0N>; Sun, 2 Dec 2001 01:26:13 -0500
Message-ID: <3C09C9CF.B6044296@ruault.com>
Date: Sat, 01 Dec 2001 22:27:27 -0800
From: Charles-Edouard Ruault <ce@ruault.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Vier <tmv5@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com> <001e01c17acb$a44b69c0$f5976dcf@nwfs> <20011202023145.A1628@emeraude.kwisatz.net> <3C09B3FA.61777E84@ruault.com> <20011202010059.A9744@zero>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes i've checked the reiserfs partitions, no problem there ....
Tom Vier wrote:

> On Sat, Dec 01, 2001 at 08:54:18PM -0800, Charles-Edouard Ruault wrote:
> > The symlink problem you're reporting is exactly what i've been experiencing among
> > other things ...
> > on both systems i had multiple ext2 partitions and one reseirfs partition.
>
> are you seeing corruption on the reiserfs? have you run reiserfsck?
>
> --
> Tom Vier <tmv5@home.com>
> DSA Key id 0x27371A2C
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

