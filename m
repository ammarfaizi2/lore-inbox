Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLLJET>; Tue, 12 Dec 2000 04:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129977AbQLLJEK>; Tue, 12 Dec 2000 04:04:10 -0500
Received: from nas1-133.kmp.club-internet.fr ([213.44.17.133]:9975 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129844AbQLLJD7>;
	Tue, 12 Dec 2000 04:03:59 -0500
Message-Id: <200012120828.JAA04872@microsoft.com>
Subject: 2.2.18pre24 spurious diskchanges
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 12 Dec 2000 07:28:27 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on my ide CDROm I get, roughly each 2 seconds, disk changes although the
drive is empty and I don't touch it:

Dec 12 08:57:43 localhost kernel: VFS: Disk change detected on device
ide0(3,64) 
Dec 12 08:58:14 localhost last message repeated 16 times
Dec 12 08:59:16 localhost last message repeated 31 times
Dec 12 09:00:17 localhost last message repeated 30 times
Dec 12 09:01:19 localhost last message repeated 31 times
Dec 12 09:02:21 localhost last message repeated 31 times
etc ...


Xav
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
