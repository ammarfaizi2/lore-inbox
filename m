Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312706AbSDGPdL>; Sun, 7 Apr 2002 11:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312797AbSDGPdK>; Sun, 7 Apr 2002 11:33:10 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:58376 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312706AbSDGPdK>; Sun, 7 Apr 2002 11:33:10 -0400
Message-ID: <3CB067FC.12ECC11C@linux-m68k.org>
Date: Sun, 07 Apr 2002 17:38:36 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
In-Reply-To: <28835.1018191216@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keith Owens wrote:

> It takes time to do all the analysis to work out what has changed and
> what has been affected.  You might know that you only changed one file
> but kernel build and make don't know that until they have checked
> everything.  Changing one file or specifying a command override might
> affect one file or it might affect the entire kernel.

Doing that analysis once is fine. After that it should know what it has
to check if I only want foo/bar.o recompiled and that shouldn't take
that long.

> Otherwise let kbuild work out what has been affected.

That's the problem with kernel hackers, they want to know what's going
on. :)

bye, Roman
