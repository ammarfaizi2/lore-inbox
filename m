Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129527AbQKHSce>; Wed, 8 Nov 2000 13:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129508AbQKHScY>; Wed, 8 Nov 2000 13:32:24 -0500
Received: from ss08.nc.us.ibm.com ([32.97.136.238]:4841 "EHLO
	ddstreet.raleigh.ibm.com") by vger.kernel.org with ESMTP
	id <S129527AbQKHScP>; Wed, 8 Nov 2000 13:32:15 -0500
Date: Wed, 8 Nov 2000 12:12:31 -0500 (EST)
From: Dan Streetman <ddstreet@us.ibm.com>
To: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
cc: Richard Polton <Richard.Polton@msdw.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.4.0-test10 problems (power-down problem)
In-Reply-To: <3A090F20.D4B42BDE@msdw.com>
Message-ID: <Pine.LNX.4.10.10011081207210.25859-100000@ddstreet.raleigh.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Nov 2000, Richard Polton wrote:

>the power switch is disabled
>too and the only way in which the machine responds is by switching
>off at the wall and pulling the battery.

I have seen this with my IBM Thinkpad 600E several times.

Many (newer, at least) IBM machines I've seen will power down if you hold the
power button down for 2-3 seconds.  Try that instead of pulling the plug and
battery.

It may be true for other machines also.

-- 
Dan Streetman
ddstreet@us.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
