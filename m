Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132572AbRDAWdg>; Sun, 1 Apr 2001 18:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRDAWd1>; Sun, 1 Apr 2001 18:33:27 -0400
Received: from smtp6vepub.gte.net ([206.46.170.27]:32031 "EHLO
	smtp6ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S132572AbRDAWdM>; Sun, 1 Apr 2001 18:33:12 -0400
Message-ID: <3AC7AC2F.D390C923@neuronet.pitt.edu>
Date: Sun, 01 Apr 2001 18:31:11 -0400
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Stephen Rothwell <sfr@canb.auug.org.au>,
   Benjamin Herrenschmidt <benh@kernel.crashing.org>,
   Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Recent problems with APM and XFree86-4.0.1
In-Reply-To: <20010331021514.A6784@pcep-jamie.cern.ch> <200103310537.f2V5bDO06729@pcug.org.au> <20010331162513.C7946@pcep-jamie.cern.ch> <20010401234156.B15813@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> I've noticed other changes in suspend/resume.  I'm running Gnome now,
> and it insists on running xscreensaver whenever I close the lid.
> Somehow it is noticing the APM event, because this is very consistent.
> Does anyone know how to disable this?  The setting "No screensaver"
> under the list of screensavers didn't help -- it just runs a blank
> screensaver which is even more confusing, because the computer appears
> not to have resumed (when it's just a black screensaver).

Look at the s option in the man pages for xset, that may help.

-- 
     Rafael
