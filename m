Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270449AbTGNQab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270451AbTGNQab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:30:31 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:45272 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270449AbTGNQa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:30:27 -0400
Date: Mon, 14 Jul 2003 18:45:07 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XBox Gaming System subarchitecture.
Message-ID: <20030714164507.GA30480@h55p111.delphi.afb.lu.se>
References: <20030714124933.GB20708@h55p111.delphi.afb.lu.se> <Pine.LNX.4.44.0307140908270.4106-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307140908270.4106-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19c6Rn-00008n-00*DaPOfAEe.M2*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 09:12:31AM -0700, Linus Torvalds wrote:
> Don't get me wrong: I think doing an Xbox port is fine. It's just that 
> putting it in the standard tree is not likely a good idea. I can well 
> imagine a number of Linux distributors who do not feel like they need the 
> aggravation ;)

Okey. Now I know, thanks. I assumed that it was either this or that it had
to follow the standard procedure of posting the mach-patch(/patchset) a
hundred times to lkml before it got accepted.

(And regarding the distros: They distributors could just rip that part out
while doing all their patches ;). And I know that at least mandrake has a
positive look on xbox-distro. And the mandrake devels were especially
helpful in porting their installer to be compatible with the xbox.)
 
Just to make clear: The patch does nothing that involves anything with the
copy-protection. Not even the hdd-unlock. It is aimed to those who replace
the bios in the xbox with the clean microsoft-free cromwell-bios, which has
the sole purpose of booting linux.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
