Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTBJDyM>; Sun, 9 Feb 2003 22:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTBJDyM>; Sun, 9 Feb 2003 22:54:12 -0500
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:18815
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S261368AbTBJDyL>; Sun, 9 Feb 2003 22:54:11 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Date: Sun, 9 Feb 2003 23:03:44 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG?][2.4.xx] - SB Driver (SBAWE32) -  Explosion sound on init
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302092303.44114.spstarr@sh0n.net>
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.114.185.204] using ID <shawn.starr@rogers.com> at Sun, 9 Feb 2003 23:03:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd, When I boot up with 2.4.20 and the sound driver is about to init I hear a 
explosion sound from the speakers each time I power off and on the machine.

Is this a initialization bug in resetting the card on boot?

Any ideas?

Shawn.

