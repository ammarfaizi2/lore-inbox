Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131819AbRA3B6C>; Mon, 29 Jan 2001 20:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131861AbRA3B5w>; Mon, 29 Jan 2001 20:57:52 -0500
Received: from [209.143.110.29] ([209.143.110.29]:63499 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S131819AbRA3B5p>; Mon, 29 Jan 2001 20:57:45 -0500
Message-ID: <3A761FEC.1C564FAE@the-rileys.net>
Date: Mon, 29 Jan 2001 20:59:08 -0500
From: David Riley <oscar@the-rileys.net>
Organization: The Riley Family
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: *massive* slowdowns on 2.4.1-pre1[1|2]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is a redundant post, but I didn't see any related posts
(at least from the subject lines)...

Kernel 2.4.1-pre11 and pre12 are both massively slower than 2.4.0 on the
same machine, compiled with the same options.  The machine is a Athlon
900 on a KT133 chipset.  The slowdown is noticealbe in all areas...
booting takes over five minutes, keyboard input is noticeably delayed,
and the PC speaker makes much longer beeps when beeping the console.  I
just wanted to post this since 2.4.1 is soon for release (at least
according to Linus' post on -pre11) and we wouldn't want to release this
if it affects more than just me.  I've tried a number of different
options to make this work, but none have seemed to work.  BTW, my
problems are nothing similar to the current discussion of KT133
misbehaviour, especially since this machine works perfectly on 2.4.0.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
