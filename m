Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbRAUX11>; Sun, 21 Jan 2001 18:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131004AbRAUX1R>; Sun, 21 Jan 2001 18:27:17 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:33796 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S131219AbRAUX1D>; Sun, 21 Jan 2001 18:27:03 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200101212327.PAA02504@cx518206-b.irvn1.occa.home.com>
Subject: 2.4.x: CONFIG_IDEDMA_NEW_DRIVE_LISTINGS paradox/doc. bug
To: linux-kernel@vger.kernel.org
Date: Sun, 21 Jan 2001 15:27:14 -0800 (PST)
Reply-To: barryn@pobox.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting from 2.4.1-pre9 (this is also in 2.4.0 and 2.4.0-ac10, I think):

>Straight GNU GCC 2.7.3/2.8.X compilers are known to be safe;
>whereas, many versions of EGCS have a problem and miscompile if you
>say Y here.

2.7.3/2.8.X can't be used to compile an out-of-the-box 2.4.x kernel, to
say the least...

(I meant to report this during 2.4test, but I'm only getting a chance
now.)

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
