Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWIPVhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWIPVhg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 17:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWIPVhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 17:37:36 -0400
Received: from igw1.zrnko.cz ([81.31.45.161]:48107 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S1751811AbWIPVhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 17:37:35 -0400
Date: Sat, 16 Sep 2006 23:38:49 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: System restart
Message-ID: <20060916213849.GJ3051@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after upgrading BIOS to the latest version on my Intel Core 2 Duo with DP965LT 
board kernel is unable to restart system. (Kernel 2.6.18-rc6.) With older BIOS
the same kernel restarts OK. The last message printed on console is: Restarting
system and system hangs.

I wonder, why "machine restart" message does not appear.

I tried kernel parameter reboot=t reboot=f reboot=t,w,f nothing helps.

-- 
Luká¹ Hejtmánek
