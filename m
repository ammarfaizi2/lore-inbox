Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLXK17>; Sun, 24 Dec 2000 05:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQLXK1t>; Sun, 24 Dec 2000 05:27:49 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:42511 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129370AbQLXK1c>;
	Sun, 24 Dec 2000 05:27:32 -0500
Date: Sun, 24 Dec 2000 09:52:57 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19pre3 clock timer config lost ?
Message-ID: <20001224095257.A1620@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: Linux grobbebol 2.2.19pre3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

never seen this before.

I run 2.2.19pre3 on a BP6.  No OC, no vmware. just the kernel wilt
lm-sensors stuff patched in.

I found that the kernel was somewhat sluggish now and then, and
this morning, this popped up in the logs :

Dec 24 02:05:05 grobbebol kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a.

Dec 24 02:05:05 grobbebol kernel: probable hardware bug: restoring chip
configuration.

which is weird I guess.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
