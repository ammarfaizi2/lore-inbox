Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbQL2D1Z>; Thu, 28 Dec 2000 22:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbQL2D1P>; Thu, 28 Dec 2000 22:27:15 -0500
Received: from m894-mp1-cvx1b.col.ntl.com ([213.104.75.126]:7684 "EHLO
	[213.104.75.126]") by vger.kernel.org with ESMTP id <S130142AbQL2D07>;
	Thu, 28 Dec 2000 22:26:59 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <sfr@linuxcare.com>
Subject: Why was this APM patch not fully applied?
From: "John Fremlin" <vii@penguinpowered.com>
Date: 29 Dec 2000 02:45:58 +0000
Message-ID: <m2k88klzbt.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Apr 04 2000 - 23:19:12 EDT, Stephen Rothwell posted a patch to linux-kernel.
See http://boudicca.tux.org/hypermail/linux-kernel/2000week15/0481.html

To quote:

This patch (against 2.3.99pre4-4) does the following: 

        Allow user mode programs to reject standby and suspend operations. 
        [...]

This first item is important to me. Unfortunately, the patch no longer
applies to current kernels (test13-pre4). Was there any reason for it
not to be included, or was it just ignored accidently?

(The patch is still available at http://linuxcare.com.au/apm/ if anyone cares.)

-- 

	http://www.penguinpowered.com/~vii
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
