Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131156AbQLKXz3>; Mon, 11 Dec 2000 18:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbQLKXzT>; Mon, 11 Dec 2000 18:55:19 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:49170 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S131156AbQLKXzJ>;
	Mon, 11 Dec 2000 18:55:09 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Signal 11
Date: Tue, 12 Dec 2000 08:24:00 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGKENMCIAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.Linu.4.10.10012111426350.706-100000@mikeg.weiden.de>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This message contains a number of related replies.)

> From: Mike Galbraith [mailto:mikeg@wen-online.de]
> Is init permanently running after you see a couple of these?

No, that is, after 23 hours up time it has used only 6 seconds CPU time
(according to top).

That reminds me that I should repeat that my signal 11 problem has (so far)
only caused X to die. The OS remains up and stable.


> From: davej@suse.de [mailto:davej@suse.de]
> My troublesome box finally seems to be stable.[...]I disabled DRM
> & AGPGart. With them both disabled, I get no problems at all.
> No Sig11's, No Sig4's, No lockups.
>
> This box has a Voodoo3 3000 AGP..

I suppose I can try this too. My box has a Matrox G400. BTW, what is DRM?
Direct Rendering something?


> From: CMA [mailto:cma@mclink.it]
> Did you already try to selectively disable L1 and L2 caches (if
> your box has both) and see what happens?

I'll look into this as well. Anyone have any pointers on how to do this? I
have a Tyan Tiger 133 with Award BIOS if this helps/matters.

Even if this setting does make a difference, what does this tell me/us? I
don't consider running the box with disabled cache(s) a viable solution.



Thanks all and keep those suggestions coming.

--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
