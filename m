Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbTBLQd7>; Wed, 12 Feb 2003 11:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTBLQd7>; Wed, 12 Feb 2003 11:33:59 -0500
Received: from main.gmane.org ([80.91.224.249]:60548 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267424AbTBLQd6>;
	Wed, 12 Feb 2003 11:33:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Re: Problems with hyper-threading on Asus P4T533 / Linux 2.4.20
Date: Wed, 12 Feb 2003 17:09:54 +0100
Organization: Programmerer Ingebrigtsen
Message-ID: <m3wuk5cwfh.fsf@quimbies.gnus.org>
References: <mng==m365rpegts.fsf@quimbies.gnus.org> <20030212.15305500@thl.ct.heise.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: never
X-Now-Playing: Blaine L. Reininger's _Night Air_: "Crash (Remix)"
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:MNadJtzmN0a4kJf+UNCAxP4GQMA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <thl@ct.heise.de> writes:

> I know some other Asus Boards that only work in HT mode when you're using 
> ACPI Patches from
>
> http://sourceforge.net/project/showfiles.php?group_id=36832

Thanks!  That solves the problem for me.  /proc/cpuinfo now shows two
CPUs.

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen

