Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSJUSO3>; Mon, 21 Oct 2002 14:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSJUSO3>; Mon, 21 Oct 2002 14:14:29 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:46013 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S261557AbSJUSO2> convert rfc822-to-8bit; Mon, 21 Oct 2002 14:14:28 -0400
X-Qmail-Scanner-Mail-From: devilkin-lkml@blindguardian.org via whocares
X-Qmail-Scanner: 1.14 (Clear:. Processed in 0.064766 secs)
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin-LKML <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre10-ac2: i/o error on cdrom diskdump
Date: Mon, 21 Oct 2002 20:20:28 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210212020.28904.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Whenever I try to dd a cdrom to an iso image I get an I/O error.  This problem 
has been present for some time, and I don't know if it's because I use 
ide-scsi or not (not been able to test).

Is this still an open issue, and is it likely to get fixed before 2.4.20 
final?

Thanks!

DK
-- 
New York's got the ways and means;
Just won't let you be.
		-- The Grateful Dead

