Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSDVTlB>; Mon, 22 Apr 2002 15:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314463AbSDVTlA>; Mon, 22 Apr 2002 15:41:00 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:56582 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314458AbSDVTlA>; Mon, 22 Apr 2002 15:41:00 -0400
Message-ID: <3CC4673B.21CD6090@linux-m68k.org>
Date: Mon, 22 Apr 2002 21:40:43 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Daniel Phillips <phillips@bonn-fries.net>, lm@bitmover.com,
        linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <Pine.LNX.4.44.0204221229440.3714-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thunder from the hill wrote:

> --- bk-kernel-howto.txt~        Mon Apr 22 12:26:50 2002
> +++ bk-kernel-howto.txt Mon Apr 22 12:26:11 2002
> @@ -15,6 +15,14 @@

I'd prefer this to be a separate document (e.g. README) and not
somewhere inbetween.

> +    Also, BitKeeper is not free software.  You may use it for free, subject
> +    to the licensing rules (bk help bkl will display them), but it is
                               ^^^^^^^^^^^

At that point it's already too late, the user must have the chance to
read this, before he installs bk.

> +    not open source.  If you feel strongly about 100% free software
> +    tool chain, then don't use BitKeeper.  Linus has repeatedly stated
                                                   
^^^^^^^^^^^^^^^^^^^^^

That has a "for all these idiots, that don't want to understand"
aftertaste, I'm certain Linus doesn't want to imply that.

bye, Roman
