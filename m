Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132805AbRC2RbX>; Thu, 29 Mar 2001 12:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132810AbRC2RbE>; Thu, 29 Mar 2001 12:31:04 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:35599 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S132805AbRC2Ram>; Thu, 29 Mar 2001 12:30:42 -0500
Message-ID: <3AC37280.ECFD4ABE@opersys.com>
Date: Thu, 29 Mar 2001 12:36:00 -0500
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, realtime@realtimelinux.org
Subject: [ANNOUNCE] Linux Trace Toolkit 0.9.5pre1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LTT 0.9.5pre1 is out.

As the name says, this is a development version and should be
treated as such. Only one kernel is supported with 0.9.5pre1,
linux 2.4.0-test10.

What it includes:
-Cross-platform reading capability submitted by Andy Lowe
-Visualizer enhancements submitted by Rocky Craig
-Patch fixes by Peng Dai and Bob Montgomery
-Many bug fixes seen using the "-Wall" flag to build the user tools

The trace format has changed again to support cross-platform
reading capabilities.

0.9.5pre1 has no support for RTAI. pre2 will include the cross-
platform capabilities for RTAI.

Here's what should be in pre2:
-Support for 2.2.18/2.4.2
-Support for the latest RTAI, including cross-platform capabilities
-Benchmark fixes from Rocky Craig
-SH support by Greg Banks

Check the project's web-site for details on 0.9.5pre1:
http://www.opersys.com/LTT

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
