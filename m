Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRHAWET>; Wed, 1 Aug 2001 18:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268434AbRHAWEK>; Wed, 1 Aug 2001 18:04:10 -0400
Received: from pop.gmx.net ([194.221.183.20]:60145 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S268432AbRHAWD6>;
	Wed, 1 Aug 2001 18:03:58 -0400
From: =?iso-8859-1?Q?Andreas_M=F6ller?= <andreas-moeller@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols in Linux 2.4.7-2.4.8-pre3
Date: Thu, 2 Aug 2001 00:04:45 +0200
Message-ID: <LKEKLBGLMHFPFPIODHNLMELBCBAA.andreas-moeller@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod: *** Unresolved symbols in
/lib/modules/2.4.8-pre3/kernel/fs/ufs/ufs.o
depmod: 	ufs_swab64

Since adding UFS support as a module to my kernel, I get this..

	Andreas

