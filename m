Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSKYOt6>; Mon, 25 Nov 2002 09:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSKYOt6>; Mon, 25 Nov 2002 09:49:58 -0500
Received: from mons.uio.no ([129.240.130.14]:28379 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S263899AbSKYOt5>;
	Mon, 25 Nov 2002 09:49:57 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: linux-kernel@vger.kernel.org
Subject: reiserfs and nfs. 
MIME-Version: 1.0
Message-Id: <E18GKCG-0003cp-00@aqualene.uio.no>
Date: Mon, 25 Nov 2002 15:26:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I'm nfs-exporting a reiserfs filesystem, the problem is that the
inode-number as seen from the client seems to change from time to
time. This confuses a number of programs, for instance Emacs believes
that the file changed under it when this happens.

Is this a known problem? Any known fix? I found a number of old
messages about problems with reiser and nfs, but not this
specifically.

-- 
 - Terje
malmedal@usit.uio.no
