Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261736AbSJMW2z>; Sun, 13 Oct 2002 18:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSJMW2z>; Sun, 13 Oct 2002 18:28:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261736AbSJMW2x>;
	Sun, 13 Oct 2002 18:28:53 -0400
Date: Sun, 13 Oct 2002 15:31:12 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Wim Van Sebroeck <wim@iguana.be>, Rob Radez <rob@osinvestor.com>,
       <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Watchdog drivers
In-Reply-To: <20021013200104.C23142@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0210131529140.22520-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Russell King wrote:

| On Sun, Oct 13, 2002 at 07:40:41PM +0200, Wim Van Sebroeck wrote:
| > I'm reviewing the different watchdog drivers and started porting the features
| > that have been added in the 2.4 kernel to the 2.5 development kernel.
| > I now wondered if it would make sence to put all watchdog drivers in
| > drivers/char/watchdog/ instead of in drivers/char ?
| > Please comments.
|
| Rob Radez has been doing a lot of work in this area; I thought he
| was going to do the 2.5 drivers as well (or his last mail on the
| 8 August seemed to imply that.)  Not sure what happened.
|
| Rob?

Rob has gone off to school and apparently has little time
for such trivial stuff.   :)

His (2.4.19-preN) patches used to live at http://junker.org/~rradez/wd/
but I can't get to that web server now.
I do have a copy of the patch file that was there if Wim
or anyone needs/wants it.

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.

