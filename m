Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSA2NKM>; Tue, 29 Jan 2002 08:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSA2NKC>; Tue, 29 Jan 2002 08:10:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62994 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288958AbSA2NJw>; Tue, 29 Jan 2002 08:09:52 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: mingo@elte.hu
Date: Tue, 29 Jan 2002 13:22:05 +0000 (GMT)
Cc: landley@trommello.org (Rob Landley),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain> from "Ingo Molnar" at Jan 29, 2002 02:54:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VYD8-0003ta-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If a patch gets ignored 33 times in a row then perhaps the person doing
> the patch should first think really hard about the following 4 issues:

Lots of the stuff getting missed is tiny little fixes, obvious 3 or 4 liners.
The big stuff is not the problem most times. That stuff does get ripped to
shreds and picked over as is needed. (Except device drivers, Linus alas has
absolutely no taste in device drivers 8))

People collecting up patches _does_ help big time for all the small fixes.
Especially ones disciplined enough to keep the originals they applied so
they can feed stuff on with that tag. If I sent Linus on a patch that said
"You've missed this fix by Andrew Morton" then Linus knew it was probably
right for example.

> it. Start small, because for small patches people will have the few

Start small and your obvious one line diff, or 3 line typo fix will be
ignored for a decade. There were critical fixes that Linus dropped
repeatedly between 2.4.2 and 2.4.16 or so which ended up being holes in every
non-ac based distro.

Alan


