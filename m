Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136159AbRDVOw5>; Sun, 22 Apr 2001 10:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136161AbRDVOwr>; Sun, 22 Apr 2001 10:52:47 -0400
Received: from ppp0a108.std.com ([208.192.100.108]:31748 "EHLO std.com")
	by vger.kernel.org with ESMTP id <S136159AbRDVOw3>;
	Sun, 22 Apr 2001 10:52:29 -0400
To: linux-kernel@vger.kernel.org
From: Francis Litterio <franl@world.std.com>
Subject: Does the scheduler run every time jiffies is incremented?
Date: 22 Apr 2001 10:52:15 -0400
Message-ID: <m31yql2di8.fsf@chantale.std.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm reading Rubini's "Linux Device Drivers" and it isn't clear to me
whether the scheduler runs every time the timer interrupt increments
jiffies or less frequently.

Does the scheduler run every time jiffies is incremented?
--
Francis Litterio
franl@world.std.com
http://world.std.com/~franl/
PGP public keys available on keyservers.
