Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbSIPN05>; Mon, 16 Sep 2002 09:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSIPN05>; Mon, 16 Sep 2002 09:26:57 -0400
Received: from [203.190.77.145] ([203.190.77.145]:39693 "HELO noc.chikka.com")
	by vger.kernel.org with SMTP id <S261487AbSIPN04>;
	Mon, 16 Sep 2002 09:26:56 -0400
Message-ID: <006301c25d85$5bfcc180$0b00000a@nocpc3>
From: "louie miranda" <louie@chikka.com>
To: <linux-kernel@vger.kernel.org>
References: <20020916160536.1482173e.raptor@tvskat.net>
Subject: Hi is this critical?? 
Date: Mon, 16 Sep 2002 21:31:18 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this critical??
I have this error's over my kern.log file and when i type dmesg..
Whats this all about? HD problems or some kernel conflict?


--
dmesg
db: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: dma_intr: error=0x40 { UncorrectableError }, LBAsect=14912550,
sector=10719504
end_request: I/O error, dev 03:42 (hdb), sector 10719504
--


--
kern.log
May 29 18:03:58 euclid ls[55] exited with preempt_count 9
May 29 18:03:58 euclid depscan.sh[54] exited with preempt_count 2
May 29 18:03:58 euclid ls[219] exited with preempt_count 1
May 29 18:03:58 euclid ls[409] exited with preempt_count 1
May 29 18:03:58 euclid depscan.sh[31] exited with preempt_count 76
May 29 18:03:58 euclid Adding Swap: 2096472k swap-space (priority -1)
May 29 18:03:58 euclid Adding Swap: 2096440k swap-space (priority -2)
May 29 18:03:58 euclid swapon[942] exited with preempt_count 3
May 29 18:03:58 euclid dmesg[943] exited with preempt_count 2
May 29 18:03:58 euclid ls[947] exited with preempt_count 1
--



Thanks,
Louie...

