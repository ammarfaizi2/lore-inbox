Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbQLHBQ3>; Thu, 7 Dec 2000 20:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbQLHBQT>; Thu, 7 Dec 2000 20:16:19 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:6417 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129805AbQLHBQG>;
	Thu, 7 Dec 2000 20:16:06 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: Signal 11
Date: Fri, 8 Dec 2000 09:44:29 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I've searched around for a answer to this with no real luck yet. If anyone
has some ideas I'd be very grateful.

	I recently upgraded to a new machine. It is running RedHat 6.2 Linux (with
a SMP 2.4.0test[8-11] kernel) and has a Matrox G400 in it. X is 4.0.1.
Anyway, about once every 2-3 days X will spontaneously die and the only info
I get back is that it was because of signal 11.
	I've heard that signal 11 can be related to bad hardware, most often
memory, but I've done a good bit of testing on this and the system seems ok.
What I did was to run the VA Linux Cerberos(sp?) test for 15 hours+ with no
errors. Actually this only worked when running from the console. When
running from X the machine locked up (although no signal 11).
	The only info I've gotten back from the XFree86 mailing lists so far is
that there are known and wide spread problems with SMP and these types of
problems. Can anyone comment on this? Are there known SMP problems? What is
the current resolution plan?


Thanks,

--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
