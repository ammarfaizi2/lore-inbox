Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132188AbQKJXkp>; Fri, 10 Nov 2000 18:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132191AbQKJXkZ>; Fri, 10 Nov 2000 18:40:25 -0500
Received: from proxy4.ba.best.com ([206.184.139.15]:26890 "EHLO
	proxy4.ba.best.com") by vger.kernel.org with ESMTP
	id <S132186AbQKJXkS>; Fri, 10 Nov 2000 18:40:18 -0500
Message-ID: <3A0C86B3.62DA04A2@best.com>
Date: Fri, 10 Nov 2000 15:37:23 -0800
From: Robert Lynch <rmlynch@best.com>
Reply-To: rmlynch@best.com
Organization: Carpe per diem
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bzImage ~ 900K with i386 test11-pre2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been regularly building kernels in the testXX series, and
they have been coming out ~ 600K; test10-final and test11-pre1:

-rw-r--r--    1 root     root       610503 Oct 31 18:39
vmlinuz-t10
-rw-r--r--    1 root     root       610568 Nov  7 20:26
vmlinuz-t11p01

test11-pre2 comes out ~ 900K:

-rw-r--r--    1 root     root       926345 Nov 10 10:16
vmlinuz-t11p02

and is thus unusable.

I believe I am following all the same steps, nothing new, make
dep bzImage modules modules_install.

Bob L.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
