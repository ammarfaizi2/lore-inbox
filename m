Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLKWKE>; Mon, 11 Dec 2000 17:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQLKWJy>; Mon, 11 Dec 2000 17:09:54 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129383AbQLKWJh>;
	Mon, 11 Dec 2000 17:09:37 -0500
Message-ID: <20001211000439.B2583@bug.ucw.cz>
Date: Mon, 11 Dec 2000 00:04:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Frédéric L . W . Meunier 
	<0@pervalidus.net>,
        linux-kernel@vger.kernel.org
Subject: Re: SysRq behavior
In-Reply-To: <20001209042444.F7282@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001209042444.F7282@pervalidus.dyndns.org>
 ; from Frédéric L . W . Meunier on Sat, Dec 0
 9, 2000 at 04:24:44AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I don't remember having the same problem months (6?) ago when
> I built my first Kernel with this enabled (well, maybe I never
> touched the key).
> 
> When built into the Kernel, by only pressing the
> PrintScreen/SysRq the current application is terminated (tested
> on a console and GNU screen). Is this just me or I should
> expect it?

Probably bug. Happens for me, too, and it is pretty nasty.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
