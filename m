Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290199AbSALBFN>; Fri, 11 Jan 2002 20:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290200AbSALBFD>; Fri, 11 Jan 2002 20:05:03 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:64 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S290199AbSALBE4>; Fri, 11 Jan 2002 20:04:56 -0500
From: brian@worldcontrol.com
Date: Fri, 11 Jan 2002 17:03:17 -0800
To: linux-kernel@vger.kernel.org
Subject: CIPE vs. GPLONLY_
Message-ID: <20020112010317.GA1765@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23.2i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

top# insmod /lib/modules/2.4.17/misc/cipcb.o
/lib/modules/2.4.17/misc/cipcb.o: unresolved symbol sk_run_filter
/lib/modules/2.4.17/misc/cipcb.o: Note: modules without a GPL compatible license cannot use GPLONLY_ symbols


running CIPE 1.5.2 I get the error above.  Should I be bother the
CIPE people with this?  Or is this some kernel thingy that needs
to be dealt with?

I remember reading on l-k a few times some stuff about GPLONLY_
but I have no idea what to do now that I've run into whatever
the problem is that is caused by this?

CIPE is a GPL'ed program.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
