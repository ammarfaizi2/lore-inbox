Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319025AbSHMUQi>; Tue, 13 Aug 2002 16:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319028AbSHMUQi>; Tue, 13 Aug 2002 16:16:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:50057 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319025AbSHMUQh>; Tue, 13 Aug 2002 16:16:37 -0400
Subject: Release announcement
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 13 Aug 2002 15:13:56 -0500
Message-Id: <1029269637.16930.17.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20020813 has been released.
Visit our website ( http://ltp.sourceforge.net ) to download the latest
version of the test suite.

There are some important fixes in this release, so please consider
upgrading.

LTP-20020813
------------
* Fixes
-------
- Fix runtest/commands to export the            ( Paul Larson        )
  correct TCdat
- Add some missing includes and remove          ( Andreas Jaeger     )
  warnings about missing prototypes
- Add better initialization to waitpid05,       ( Robbie Williamson  )
  signal04, getgroups01
- Fix sockioctl01 to work even if fd0 isn't     ( Paul Larson        )
  open
- Fix mmstress path problems, now uses execvp   ( Paul Larson        )



