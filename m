Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272670AbRIPS02>; Sun, 16 Sep 2001 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272664AbRIPS0T>; Sun, 16 Sep 2001 14:26:19 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:40663 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S272661AbRIPS0H>;
	Sun, 16 Sep 2001 14:26:07 -0400
Message-ID: <003e01c13edd$24c947f0$6400a8c0@it0>
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: smp problem on 2.4.x
Date: Sun, 16 Sep 2001 20:26:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just want to report a problem I am having.
I have an asus P2L97-DS with 2 different PII cpu's on it.
1 is a PII 233@66
1 is a PII 350@100
Since they both run at 66 MHZ (LX board)  this isn't a problem and works
fine on a 2.2.20 pre7 kernel.
However all 2.4.x kernels I make won't run on it, after (while?) mounting
ext2 / i get invalid operand 0000, trying to kill an idle task.

I have the feeling that this is due to my configuration as I believe that I
read somewhere that the stepping should be the same.

If I am doing something wrong just say it and if not then I hope you'll spot
the bug.

Tommy

