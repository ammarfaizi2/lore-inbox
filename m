Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289169AbSAMMoE>; Sun, 13 Jan 2002 07:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289170AbSAMMn5>; Sun, 13 Jan 2002 07:43:57 -0500
Received: from chello212186127068.14.vie.surfer.at ([212.186.127.68]:47002
	"EHLO server.home.at") by vger.kernel.org with ESMTP
	id <S289169AbSAMMnh>; Sun, 13 Jan 2002 07:43:37 -0500
Subject: floating point exception
From: Christian Thalinger <e9625286@student.tuwien.ac.at>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Jan 2002 13:43:21 +0100
Message-Id: <1010925802.674.0.camel@sector17.home.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just downloaded again, after a long time, the setiathome client. I
wanted to look how smooth my tyan dual works. So i started the client
and after a few seconds it gets and `floating point exception'. No
problem till now, cause it seems to be seti bug. Ok. 

Right after that my window manager segfaults. Ok, switch to console,
restart it and go. No! Can't start any programs anymore, no login. All
tasks die one after the other, up to the complete lock of the machine.
Even alt-sysrq doesn't work.

So, this is kernel 2.4.17 and i'll try other kernels right after this
email.

Anyone knows what's going on?


