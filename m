Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRDIRg6>; Mon, 9 Apr 2001 13:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132806AbRDIRgs>; Mon, 9 Apr 2001 13:36:48 -0400
Received: from mp-217-231-38.daxnet.no ([193.217.231.38]:38951 "EHLO
	pilt.home.garstad.net") by vger.kernel.org with ESMTP
	id <S132805AbRDIRgg> convert rfc822-to-8bit; Mon, 9 Apr 2001 13:36:36 -0400
Message-ID: <006101c0c11b$a0a46520$01000001@pompel>
From: "Ola Garstad" <olag@eunet.no>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Reiser FS doesn't work with 2.4.4-pre1?
Date: Mon, 9 Apr 2001 19:36:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After patching from 2.4.3 to 2.4.4-pre1 my reiserfs volumes failed to mount.

I checked that reiserfs was included and tried to load the module manualy. This gave this result:

lib/modules/2.4.4-pre1/kernel/fs/reiserfs/reiserfs.o: unresolved symbol strstr
/lib/modules/2.4.4-pre1/kernel/fs/reiserfs/reiserfs.o: insmod /lib/modules/2.4.4-pre1/kernel/fs/reiserfs/reiserfs.o failed
/lib/modules/2.4.4-pre1/kernel/fs/reiserfs/reiserfs.o: insmod reiserfs failed




