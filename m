Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRBIUCH>; Fri, 9 Feb 2001 15:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRBIUB5>; Fri, 9 Feb 2001 15:01:57 -0500
Received: from kiln.isn.net ([198.167.161.1]:1863 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S129734AbRBIUBv>;
	Fri, 9 Feb 2001 15:01:51 -0500
Message-ID: <3A844C76.59CBEE74@isn.net>
Date: Fri, 09 Feb 2001 16:00:54 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: compiling 2.4.1 with binutils-2.10.1.0.7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bbootsect.s:253 warning indirect lcall without *
ld cannot open binary: no such file or directory
binutils-2.10.0.33 works, but gives lots of similar warnings elsewhere.
just a headsup.
Garst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
