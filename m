Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKRFqb>; Sat, 18 Nov 2000 00:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKRFqW>; Sat, 18 Nov 2000 00:46:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39684 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129091AbQKRFqG>;
	Sat, 18 Nov 2000 00:46:06 -0500
Message-ID: <3A161077.7C94EC6E@mandrakesoft.com>
Date: Sat, 18 Nov 2000 00:15:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: EXPORT_NO_SYMBOLS vs. (null) ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the difference between a module that exports no symbols and
includes EXPORT_NO_SYMBOLS reference, and such a module that lacks
EXPORT_NO_SYMBOLS?

Alan once upbraided me for assuming they were the same :)

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
