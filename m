Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbQLNMiJ>; Thu, 14 Dec 2000 07:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131154AbQLNMh7>; Thu, 14 Dec 2000 07:37:59 -0500
Received: from gull.prod.itd.earthlink.net ([207.217.121.85]:14514 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130507AbQLNMhs>; Thu, 14 Dec 2000 07:37:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12 lockups -- need feedback
Date: Thu, 14 Dec 2000 07:10:10 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.30.0012132157020.1272-100000@viper.haque.net> <Pine.LNX.4.30.0012132244290.1875-100000@viper.haque.net> <20001214132118.A829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20001214132118.A829@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Message-Id: <00121407101000.00542@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay. got it here this morning, too. solid lock -- no dumping out of 
x, no changing terminals, no mouse, no keyboard.

k6-2-550 @ 500; 256mb memory, fic 503a mb with via chipset. kernel 
built with gcc-2.95-2 against glibc-2.2. nothing remarkable underway 
-- was composing a message in kmail, which i've done successfully 
multiple times since upgrading to test12.
-- 
dep
--
bipartisanship: an illogical construct not unlike the idea that
if half the people like red and half the people like blue, the 
country's favorite color is purple.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
