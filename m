Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261976AbSI3JXw>; Mon, 30 Sep 2002 05:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbSI3JXw>; Mon, 30 Sep 2002 05:23:52 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:58898 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261976AbSI3JXv>; Mon, 30 Sep 2002 05:23:51 -0400
Message-ID: <3D98197D.2A802702@aitel.hist.no>
Date: Mon, 30 Sep 2002 11:29:33 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.36 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.39 won't boot, UP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.36 works fine on this machine.

2.5.39 UP don't boot at all. I get a black screen
and hanging machine right after lilo, no messages
at all from the kernel trying to boot.
Any ideas about what can go wrong so early?
I tried make mrproper and recompiling, it
made no difference.

The machine is a PII with 256M RAM and a intel 440
chipset.

Helge Hafting
