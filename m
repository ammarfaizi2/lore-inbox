Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131726AbRCTGx4>; Tue, 20 Mar 2001 01:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCTGxq>; Tue, 20 Mar 2001 01:53:46 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:23559 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S131726AbRCTGxb>; Tue, 20 Mar 2001 01:53:31 -0500
Message-ID: <3AB6FF94.D957087B@opersys.com>
Date: Tue, 20 Mar 2001 01:58:28 -0500
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, realtime@realtimelinux.org
Subject: [ANNOUNCE] Linux Trace Toolkit version 0.9.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This new release of the Linux Trace Toolkit includes complete
support for Linux and RTAI on both ix86 and PPC. With this out,
work on other architectures is in its way. Anyone wanting
to dig-in is welcomed to do so.

Also, 0.9.4 includes all the additions that were made in the
0.9.4preX series. This includes interfacing with DProbes
using dynamic event creation and usage of rvmalloc and friends
to avoid having to copy large portions of memory from kernel
space to user space.

In order to encourage exchanges and discussions, I've set
up mailing lists for LTT. Please take a look at the "mailing
lists" section of the project's web-site for more detail.

You can find LTT at:
http://www.opersys.com/LTT

Cheers,

Karim Yaghmour

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
