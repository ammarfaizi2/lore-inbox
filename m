Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQLFTpp>; Wed, 6 Dec 2000 14:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbQLFTpg>; Wed, 6 Dec 2000 14:45:36 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:43012 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130105AbQLFTp0>; Wed, 6 Dec 2000 14:45:26 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200012061700.RAA19381@mauve.demon.co.uk>
Subject: Booting on the wrong processor.
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Dec 2000 17:00:05 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just had a frustrating experience, solely blameable on my
own stupidity.
Basically, I'd been assuming that stopping after "booting kernel" was
due to some corruption, rather than the obvious, of checking that I had
indeed selected the right processor when compiling.

What about "booting the kernel for i386" ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
