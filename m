Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265386AbTIDSGb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265397AbTIDSGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:06:31 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:17081 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S265386AbTIDSGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:06:14 -0400
Date: Thu, 4 Sep 2003 20:05:54 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: BUG: 2.4.23-pre3 + ifconfig
Message-ID: <20030904180554.GA21536@oasis.frogfoot.net>
Mail-Followup-To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 20:01:11 up 16 days, 1:16, 4 users, load average: 0.04, 0.04, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I just installed 2.4.23-pre3 on one of our servers. If I up/down the
loopback device multiple times ifconfig hangs on the second down (as in
unkillable) and afterwards ifconfig stops functioning and I can't reboot the
machine, etc.

No oopses, kernel panics, messages or anything. The system is still alive,
it is just as if some system call is hung.

If anyone is interested, I can send my .config or any other relevant details.

-- 

Regards
 Abraham

"Consequences, Schmonsequences, as long as I'm rich."
		-- "Ali Baba Bunny" [1957, Chuck Jones]

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

