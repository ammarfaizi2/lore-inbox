Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSBOMyw>; Fri, 15 Feb 2002 07:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288987AbSBOMyd>; Fri, 15 Feb 2002 07:54:33 -0500
Received: from angband.namesys.com ([212.16.7.85]:17030 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S288960AbSBOMyU>; Fri, 15 Feb 2002 07:54:20 -0500
Date: Fri, 15 Feb 2002 15:54:13 +0300
From: Oleg Drokin <green@namesys.com>
To: Sebastian =?koi8-r?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs Corruption with 2.5.5-pre1
Message-ID: <20020215155413.A7974@namesys.com>
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de> <20020214180501.A1755@namesys.com> <20020214162232.5e59193b.sebastian.droege@gmx.de> <20020214172421.5d8ae63c.sebastian.droege@gmx.de> <20020214192633.A2311@namesys.com> <20020215135223.46af1b28.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020215135223.46af1b28.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
On Fri, Feb 15, 2002 at 01:52:23PM +0100, Sebastian Dröge wrote:

> > Do these files disa[[ear after you quit GNOME?
> They don't disappear but I can't reproduce the behaviour anymore...
> I've run reiserfsck --fix-fixable, it detects one error, fixes that and after reboot the files were gone in 2.4.17 AND 2.5.5-pre1
What was the error?

> I had this behaviour before the reiserfscks but I thought it has something to do with the files
> 2.4.17, again, runs without any problems
> Maybe somebody can test if he can start gnome-terminal with 2.5.5-pre1
Where do these gnome-terminal hangs? (check ps axl output,
also sysrq-t may be of some help)

Bye,
    Oleg
