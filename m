Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318316AbSHEU7f>; Mon, 5 Aug 2002 16:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318879AbSHEU7f>; Mon, 5 Aug 2002 16:59:35 -0400
Received: from pdbn-d9b8caad.pool.mediaWays.net ([217.184.202.173]:5641 "EHLO
	korben.citd.de") by vger.kernel.org with ESMTP id <S318316AbSHEU7e>;
	Mon, 5 Aug 2002 16:59:34 -0400
Date: Mon, 5 Aug 2002 23:03:04 +0200 (CEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: Heavy Clock-Drift after update from Kernel 2.4.9 to 2.4.19
Message-ID: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>



I updated to 2.4.19 the day after it was released. Since then i have a
heavy clock-drift problem.

Some time there is no clock drift, other times there is heavy clock drift.

e.g. When i load a page with mozilla. The "rotating thing" spins
randomly fast/normal.
Or when i play a movie with "xine". Every few seconds the playing gets
faster and then back to normal.

With 2.4.9 the clock was "rock solid" for weeks.

A bit strange is that it seems to depend on load. Higher load seems to
cause less/none clock drift.
(e.g. when i compile something in background, the "rotating thing" in
mozilla doesn't spin to fast)

Hardware is a Dual-PIII-933Mhz. Kernel is configured as SMP.
Any more details needed?




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.


