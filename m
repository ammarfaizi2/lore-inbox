Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261207AbSJCVNc>; Thu, 3 Oct 2002 17:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSJCVNc>; Thu, 3 Oct 2002 17:13:32 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.232.94]:1540
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261207AbSJCVNZ>; Thu, 3 Oct 2002 17:13:25 -0400
Message-ID: <001601c26b21$f556e280$bf00000a@SYEDDESKTOP>
From: "Shawn Starr" <spstarr@sh0n.net>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Patch release - 2.4.20-pre7-rmap14a-shawn12d.1
Date: Thu, 3 Oct 2002 17:15:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch release
===============

xfs-2.4.20-pre7-rmap14a-uml-shawn12d.1 against 2.4.19 vanilla. (October 3rd,
2002)

- Fixed KDB compile errors (due to changes in page structure)

- Fixed symbol error (vmap) when not using XFS file system

- Fixed symbol error (grab_cache_page) missing in pagemap.h


you can get it at:

http://xfs.sh0n.net/2.4/testing/linux-shawn12d.1.diff.patch

Note: Site is having connectivity issues right now (the machine looks dead
;))

Shawn.


