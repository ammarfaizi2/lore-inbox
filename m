Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131736AbRCQS0Y>; Sat, 17 Mar 2001 13:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRCQS0P>; Sat, 17 Mar 2001 13:26:15 -0500
Received: from proxyd.rim.net ([206.51.26.194]:32412 "HELO mhs99ykf.rim.net")
	by vger.kernel.org with SMTP id <S131736AbRCQS0J>;
	Sat, 17 Mar 2001 13:26:09 -0500
Message-ID: <A9FD1B186B99D4119BCC00D0B75B4D8104D4AA30@xch01ykf.rim.net>
From: Aaron Lunansky <alunansky@rim.net>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'kees@shoen.nl'" <kees@shoen.nl>
Subject: Re: [OT] how to catch HW fault
Date: Sat, 17 Mar 2001 13:22:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds like the only thing you haven't swapped out of your machine is the
ram/cpu.

It could very well be your ram (I don't suspect the cpu). If you can, try a
different stick of ram.



-----Original Message-----
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Sent: Sat Mar 17 11:29:35 2001
Subject: [OT] how to catch HW fault

Hi,
I'm getting mad because of random freezes of my system. Linux-2.2.19pre7
on MSI 694D dual PIII(677MHz) 128 MB, no OC. I tried to isolate the
problem with replacing cards (S3 video, 3com 59X, ES1373 and
AIC7xxx) didn't solve anything. Even in initlevel 1 with only a videocard
the freeze happens. It is a total lockup, no SYSRQ , no ping from network,
nothing in the logs. A freeze may happen 4 times in a hour or once in 2
weeks. I have the same mobo and PIII's at home without the slightest
problems. Who knows of a suitable diagnostics to track this down?
regards
Kees



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
