Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSGGXp5>; Sun, 7 Jul 2002 19:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSGGXp4>; Sun, 7 Jul 2002 19:45:56 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:59653 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S316667AbSGGXpz>; Sun, 7 Jul 2002 19:45:55 -0400
Message-ID: <3D28D38F.DA872606@opersys.com>
Date: Sun, 07 Jul 2002 19:49:35 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Philippe Gerum <rpm@idealx.com>
Subject: [ANNOUNCE] Adeos now supports SMP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While most of us were at the OLS, Philippe continued hacking on Adeos
and has extended the functionality to include SMP support. In light
of the discussions I had with many folks at the OLS (the K42 team,
Larry, Paul and others), this is a positive step forward to having
multiple Linux kernels running on the same hardware.

The code has been tested on a dual PIII. Of course, further testing
and comments are most welcome. The latest CVS snapshot is available
at: http://savannah.gnu.org/download/adeos/snapshots/

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
