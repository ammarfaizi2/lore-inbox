Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSGOUEQ>; Mon, 15 Jul 2002 16:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSGOUEP>; Mon, 15 Jul 2002 16:04:15 -0400
Received: from [209.184.141.189] ([209.184.141.189]:25121 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317611AbSGOUEP>;
	Mon, 15 Jul 2002 16:04:15 -0400
Subject: Some sysctl parameter change questions.
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 15 Jul 2002 15:07:02 -0500
Message-Id: <1026763622.14848.0.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking through some tuning documentation about sysctl values as related
to Oracle and other DB tuning bits, I noticed that the following don't
exist anymore, and was curious where or if they were moved.

/proc/sys/kernel/inode-max
/proc/sys/vm/freepages

In coincidence with this info, I was curious if anyone has tweaked the
following and if it makes any difference, with regard to performance:

/proc/fs/pagebuf
/proc/sys/vm/pagebuf
/proc/sys/vm/pagebuf/max_dio_pages
/proc/sys/vm/page-cluster
/proc/sys/vm/pagetable_cache


-- 
Austin Gonyou <austin@digitalroadkill.net>
