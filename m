Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293619AbSCSDhR>; Mon, 18 Mar 2002 22:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293626AbSCSDhI>; Mon, 18 Mar 2002 22:37:08 -0500
Received: from unknown.Level3.net ([64.156.114.22]:40675 "EHLO bish.net")
	by vger.kernel.org with ESMTP id <S293619AbSCSDgz>;
	Mon, 18 Mar 2002 22:36:55 -0500
Date: Mon, 18 Mar 2002 22:23:32 -0500 (EST)
From: Mark <mark@bish.net>
To: linux-kernel@vger.kernel.org
Subject: C-Media 8738 sound driver + A7M266-D problems.
Message-ID: <Pine.LNX.4.43.0203182216260.32113-100000@bish.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a dual AMD board that has the 8738 onboard.  I compile 2.4.18 and
pass it the '6 speaker' selection which should push the Rear speaker
signal out the Line In connector and the Center Speaker Out/ Sub-woofer
signal out the Mic In connector.  This does not happen.  I've tried this
as a module and passing the params on the command line as well as
compiling it directly into the kernel.  Am I missing something (very
likely) or is this a known situation that I just have to deal with?


Please Cc: me.  I am not subscribed to the list.


------------------------------------------------------------------------
| Mark Bishop  (mark@bish.net)         |             Computer Engineer |
| 813-253-XXXX                         |             Network Engineer  |
| http://bish.net                      |          Embedded Programmer  |

