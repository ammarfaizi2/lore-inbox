Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSEULbe>; Tue, 21 May 2002 07:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSEULbd>; Tue, 21 May 2002 07:31:33 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:17416 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S312581AbSEULbd>; Tue, 21 May 2002 07:31:33 -0400
From: Rene Blokland <reneb@orac.aais.org>
Subject: floppy always read-only in 2.5.12+
Date: Tue, 21 May 2002 13:31:09 +0200
Organization: Cistron
Message-ID: <slrnaekbvt.4u.reneb@orac.aais.org>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1021980693 20240 195.64.94.30 (21 May 2002 11:31:33 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, my desktop has a buildin floppy not an ide but and oldfasion one.
The mb is an ASUS p5a with an AMD k6 processor
When i try to do a dd to /dev/fd0 as root, it compaining about a Read-Only
filesystem.
Also lilo has this problem. is it a bug or did I miss something?
Thanks for your answer.

--
Groeten / Regards, Rene J. Blokland

