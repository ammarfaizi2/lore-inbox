Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290790AbSBFUYx>; Wed, 6 Feb 2002 15:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290791AbSBFUYo>; Wed, 6 Feb 2002 15:24:44 -0500
Received: from pasky.ji.cz ([62.44.12.54]:4857 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S290790AbSBFUYc>;
	Wed, 6 Feb 2002 15:24:32 -0500
Date: Wed, 6 Feb 2002 21:24:15 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: linuxconsole-dev@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, gpm@lists.linux.it, salvador@inti.gov.ar,
        jsimmons@transvirtual.com
Subject: Reworking the selection API and moving it to userspace (gpm)?
Message-ID: <20020206202415.GV8510@pasky.ji.cz>
Mail-Followup-To: linuxconsole-dev@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, gpm@lists.linux.it,
	salvador@inti.gov.ar, jsimmons@transvirtual.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  About June 2001, in the era of 2.4.7 kernel, there occured a patch on LKML
(by Salvador Eduardo Tropea <salvador@inti.gov.ar>), which improved the actual
selection API of kernel to allow applications to get the content of the
selection buffer etc. However, James Simmons said that he will be working on
this for 2.5 and move it to userspace completely, reworking gpm.

  Nevertheless, I didn't saw a notice about this at all since then - there's no
metion about this on linuxconsole's project homepage, in the 2.5 todo list nor
anywhere else - and as I'm looking forward for this change a lot, I would like
to ask if there's any movement in this issue. I would be even willing to help,
if possible :).

  Kind regards,

-- 

				Petr "Pasky" Baudis

* UN*X programmer && admin         * IPv6 guy (XS26 co-coordinator)
* elinks maintainer                * FreeCiv AI hacker
* IRCnet local operator
.
"Something has fallen on us that falls very seldom on men; perhaps the worst
thing that can fall on them.
We have found the truth; and the truth makes no sense."
		-- Father Brown
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
