Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280754AbRKSWTE>; Mon, 19 Nov 2001 17:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280757AbRKSWSy>; Mon, 19 Nov 2001 17:18:54 -0500
Received: from bones.kulnet.kuleuven.ac.be ([134.58.253.193]:47317 "HELO
	pedro.unibuc.ro") by vger.kernel.org with SMTP id <S280750AbRKSWSm>;
	Mon, 19 Nov 2001 17:18:42 -0500
Message-ID: <3BF985A4.5B4AE053@abcpages.com>
Date: Mon, 19 Nov 2001 23:20:20 +0100
From: Nicolae Mihalache <mache@abcpages.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problems with Pioneer DVD-ROM 116
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I recently bought a Pioneer 116 DVD-ROM drive and I see strange things
happening. I can't read DVDs with it in standard IDE mode. If I try the
command "cat /dev/hdc" nothing is returned and there is no error like
the DVD inside has capacity 0. However if I use SCSI emulation
everything work perfect. I tried with kernel 2.4.6 and 2.4.14. The drive
works fine with CDs and unfortunately so far I only tried with DVD-R and
DVD-RW produced with another Pioneer DVD writer. I don' know if it works
with a real DVD disk but it should make no difference.
Please CC me in the answer because I'm not subscribed.

Thanks,
mache
