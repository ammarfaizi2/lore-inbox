Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSIJUNb>; Tue, 10 Sep 2002 16:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSIJUNa>; Tue, 10 Sep 2002 16:13:30 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:12720 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S317859AbSIJUN2>; Tue, 10 Sep 2002 16:13:28 -0400
Message-Id: <200209102029.g8AKTErF000328@pool-141-150-242-242.delv.east.verizon.net>
Date: Tue, 10 Sep 2002 16:29:13 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Using multimedia keys with new input layer
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop015.verizon.net from [141.150.242.242] using ID <vze2j9fk@verizon.net> at Tue, 10 Sep 2002 15:18:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can no longer use setkeycodes to customize my keyboard layout.  It
stopped working with the new input layer.  showkey also no longer shows
scan codes.

I usually use setkeycodes for about 10 keys.  Now 9 of the calls have no
effect and the 10th changes the actual scan code for the letter 'w' not
the key code.

Anyone know what I'm doing wrong?  Is there some kernel option I missed
that allows it? or an alternate way to do it?  I haven't noticed anyone
else having the same trouble.

-- 
Skip
