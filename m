Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQKUElj>; Mon, 20 Nov 2000 23:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbQKUEl2>; Mon, 20 Nov 2000 23:41:28 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:13323 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S129465AbQKUElM>; Mon, 20 Nov 2000 23:41:12 -0500
Message-ID: <3A19F5D8.38BF5384@home.com>
Date: Mon, 20 Nov 2000 22:11:04 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel list <linux-kernel@vger.kernel.org>
Subject: Assembler warnings
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I see these warnings while compiling modules in 2.4.0-test10.  This
is with RH 7.0's kgcc (why-oh-why did they base their system on
2.96!!).  It doesn't seem to break anything--I'm just curious as to what
the warnings signify.


{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for
.modinfo

-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
