Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSJRDjQ>; Thu, 17 Oct 2002 23:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSJRDjP>; Thu, 17 Oct 2002 23:39:15 -0400
Received: from nameservices.net ([208.234.25.16]:55260 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262877AbSJRDjP>;
	Thu, 17 Oct 2002 23:39:15 -0400
Message-ID: <3DAF850D.D104A6D@opersys.com>
Date: Thu, 17 Oct 2002 23:50:37 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [ANNOUNCE] LTT 0.9.6pre2: Per-CPU buffers, TSC timestamps, etc.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new development version of LTT is now available, 0.9.6pre2.
Here's what's new:
- Per-CPU buffering
- TSC timestamping
- Use of syscall interface instead of char dev abstraction

The release includes a patch for 2.5.43 which is pretty much ready
for inclusion. I will be posting this patch raw ot the LKML with
a more verbose description.

You will find 0.9.6pre2 here:
http://www.opersys.com/ftp/pub/LTT/

LTT's web site is here:
http://www.opersys.com/LTT

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
