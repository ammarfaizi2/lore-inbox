Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264860AbRGNU2r>; Sat, 14 Jul 2001 16:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbRGNU2h>; Sat, 14 Jul 2001 16:28:37 -0400
Received: from mail.eunet.ch ([146.228.10.7]:54798 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S264860AbRGNU2T>;
	Sat, 14 Jul 2001 16:28:19 -0400
Message-ID: <3B50C783.F4E9A8A7@dial.eunet.ch>
Date: Sat, 14 Jul 2001 22:28:19 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre7aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.x swap >= 2*memsize requirements status.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My practical experience with 2.2.20pre7aa1:

3 machines _without_ swap space (disabled),

2 UP's with 512 MiB memory,
one dual SMP with 1024 MiB memory,

no problems since months and 20pre#aa#.
Latency is minor than _with_ swap!

Mario

PS Not in lkml, so cc if needed.
