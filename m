Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSGIOPR>; Tue, 9 Jul 2002 10:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSGIOPQ>; Tue, 9 Jul 2002 10:15:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58355 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315406AbSGIOPP>; Tue, 9 Jul 2002 10:15:15 -0400
Date: Tue, 9 Jul 2002 16:17:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] using 2.5.25 with IDE
Message-ID: <Pine.SOL.4.30.0207091613350.16892-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Contrary to the popular belief 2.5.25 has only Martin's IDE-93
and has broken locking...

If you want to run IDE on 2.5.25 get and apply:

IDE-94 by Martin
IDE-95/96/97/98-pre by me

from:
http://home.elka.pw.edu.pl/~bzolnier/ata/

--
Bartlomiej

