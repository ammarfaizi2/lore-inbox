Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270647AbRHJVTq>; Fri, 10 Aug 2001 17:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270649AbRHJVTf>; Fri, 10 Aug 2001 17:19:35 -0400
Received: from pD9516138.dip.t-dialin.net ([217.81.97.56]:57849 "EHLO
	bonzo.nirvana") by vger.kernel.org with ESMTP id <S270645AbRHJVTW>;
	Fri, 10 Aug 2001 17:19:22 -0400
Date: Fri, 10 Aug 2001 23:19:06 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: Remotely rebooting a machine with state 'D' processes, how?
Message-ID: <20010810231906.A21435@bonzo.nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I reboot a stuck machine remotely, when there are uninterruptable
processes arround? shutdown -r, reboot [-n] [-f], telinit 6 do not give the
intended results. Localy I can use Alt-SysRq-S/U/B, but what if I still have a
remote ssh connection and don't want to have to get to the machines location?

Of course the real problem are the processes themselves, but being able to
revive a machine is also nice ;)

Regards, Axel.
-- 
Axel.Thimm@physik.fu-berlin.de
