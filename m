Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbQLYQzk>; Mon, 25 Dec 2000 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130475AbQLYQzb>; Mon, 25 Dec 2000 11:55:31 -0500
Received: from avocet.prod.itd.earthlink.net ([207.217.121.50]:53905 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131755AbQLYQzT>; Mon, 25 Dec 2000 11:55:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: serial mouse - lockup connection 2.4.0-t12
Date: Mon, 25 Dec 2000 11:27:39 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <00122511273900.01170@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greetings!

the lockup of test12 leaves no droppings i can find, but in the 
course of a half-dozen lockups in the last few days i've made an 
observation or two that may be of diagnostic help.

system is a k6-2 on a via chipset mb with onboard everything but 
video (fic va-503a). kernel built with gcc-2.95.2. glibc is 2.2.

the lockups occur during mouse movement -- mouse is kensington 
emulating microsoft. the peculiar thing is that the mouse 
acceleration seems to slow a little in the seconds before the lockup. 
i don't know that this is a useful datum, but it seemed as if it 
might be significant.

the lockups are otherwise neither predictable or reproducible.
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
