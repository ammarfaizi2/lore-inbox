Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbQLNLa1>; Thu, 14 Dec 2000 06:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbQLNLaR>; Thu, 14 Dec 2000 06:30:17 -0500
Received: from a75d1hel.dial.kolumbus.fi ([193.229.161.75]:57607 "EHLO
	darkmoon.imagesoft") by vger.kernel.org with ESMTP
	id <S130425AbQLNLaF>; Thu, 14 Dec 2000 06:30:05 -0500
Message-ID: <3A38A825.DE416521@imagesoft.fi>
Date: Thu, 14 Dec 2000 12:59:49 +0200
From: Jussi Laako <jussi.laako@imagesoft.fi>
Organization: Image Soft Oy
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory subsystem error and freeze on 2.4.0-test12
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is this normal:

Dec 14 12:33:32 alien kernel: __alloc_pages: 2-order allocation failed.

System deadlocked about one minute later.

I have hard resource limits set.

 - Jussi Laako

-- 
PGP key fingerprint: 3827 6A53 B7F9 180E D971  362B BB53 C8A1 B578 D249
Available at: ldap://certserver.pgp.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
