Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbRAECs6>; Thu, 4 Jan 2001 21:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRAECss>; Thu, 4 Jan 2001 21:48:48 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:12729 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129901AbRAECsl>;
	Thu, 4 Jan 2001 21:48:41 -0500
Message-ID: <3A553608.8BFD1BB7@voicenet.com>
Date: Thu, 04 Jan 2001 21:48:40 -0500
From: safemode <safemode@voicenet.com>
Organization: none
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI in Via Apollo (vt82C686) broken badly in 2.4.x ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, it seems the only way to look at sensor readings with lmsensors is
to activate acpi in linux for my motherboard.  According to the docs, my
motherboard is supposed to be supported and is detected when linux
boots, the problem comes when i try to move the mouse (in console and
X).  It totally flips out, i get irregular mouse movement across the
screen and button clicks when i just barely touched it.  It is directly
related to enabling acpi so i was wondering if anyone else has had this
problem and if there was/is a fix for it or if it's a bug right now.
If there is specific debugging info that i can get to help, tell me
where... dmesg just shows successful messages.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
