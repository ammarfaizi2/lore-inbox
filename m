Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbQLJXrK>; Sun, 10 Dec 2000 18:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQLJXrC>; Sun, 10 Dec 2000 18:47:02 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:17075 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129774AbQLJXqw>; Sun, 10 Dec 2000 18:46:52 -0500
Message-ID: <3A340EC7.9735E93@haque.net>
Date: Sun, 10 Dec 2000 18:16:23 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827! and scsi modules no load at boot w/ 
 initrd - test12pre7
In-Reply-To: <3A2FF076.946076FC@haque.net> <90p2ds$2hs$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is seems to be fixed in test12-pre8.

Linus Torvalds wrote:
> Do you have something special that triggers this? Can you test if it
> only happens with initrd, for example?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
