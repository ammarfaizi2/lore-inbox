Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbTCCCSZ>; Sun, 2 Mar 2003 21:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTCCCSZ>; Sun, 2 Mar 2003 21:18:25 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:7410 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268286AbTCCCSY>; Sun, 2 Mar 2003 21:18:24 -0500
Date: Mon, 03 Mar 2003 15:31:36 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-reply-to: <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046658694.8547.44.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 12:55, Patrick Mochel wrote:

> http://ldm.bkbits.net:8080/linux-2.5-power

Hi. again.

I've taken a look at the comments for your changesets, and our changes
do indeed conflict in a number of places. I'm happy to wait until your
cleanups get included and then merge from there. I've had a brief go at
using BK, but I'm only on a 56K connection, so I'm not sure how
practical it is for me to do pulls etc. I guess for the moment the best
path for me to take might be to continue to port 2.4 and then merge with
you once I'm done.

Regards,

Nigel

