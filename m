Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQLDSya>; Mon, 4 Dec 2000 13:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLDSyV>; Mon, 4 Dec 2000 13:54:21 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:47281 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S129371AbQLDSyE>;
	Mon, 4 Dec 2000 13:54:04 -0500
Message-ID: <3A2BE10F.7FA1EF66@ife.ee.ethz.ch>
Date: Mon, 04 Dec 2000 19:23:11 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: de,fr,ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@suse.cz>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio 2.4.0-test11
In-Reply-To: <E14309P-00045b-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> What format is it that causes the problems, the only badly supported key format
> right know I know of is 16bit bigendian. That needs some small esd patches.

S8 is a not very well supported format.

And btw there are many applications that cannot live with esd for
latency
reasons.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
