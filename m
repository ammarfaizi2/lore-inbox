Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131703AbQLJSsI>; Sun, 10 Dec 2000 13:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131641AbQLJSr6>; Sun, 10 Dec 2000 13:47:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48393 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131703AbQLJSrs>; Sun, 10 Dec 2000 13:47:48 -0500
Subject: Re: 2.2.18pre21 oops reading /proc/apm
To: neale@lowendale.com.au (Neale Banks)
Date: Sun, 10 Dec 2000 18:18:33 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sfr@linuxcare.com (Stephen Rothwell),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10012101630560.16389-100000@marina.lowendale.com.au> from "Neale Banks" at Dec 10, 2000 06:14:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145B3T-0006oO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it "obvious" that I'm dealing with the same or similar kind of
> bugginess here?

Obvious no, but its a pretty good guess.

> 
> That being the case, any reason I can't/shouldn't put in a function
> similar to apm_battery_horked(), and call/run it based on a config-time
> variable?

None at all

> FWIW, the machine claims "Phoenix NoteBIOS" dated 1994, and the poweroff
> bit of APM appears to work just fine.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
