Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291026AbSBGBDD>; Wed, 6 Feb 2002 20:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291022AbSBGBCy>; Wed, 6 Feb 2002 20:02:54 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:48101 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S291020AbSBGBCt>; Wed, 6 Feb 2002 20:02:49 -0500
Date: Thu, 7 Feb 2002 02:55:23 +0100
From: Fabrice Eudes <fabrice@oberon.ambre.fr>
To: linux-kernel@vger.kernel.org
Cc: Club LinuX <clx@gaia.anet.fr>,
        Utilisateurs Debian =?iso-8859-1?Q?Fran=E7ais?= 
	<debian-user-french@lists.debian.org>
Subject: [Re: Can't boot 2.4.17 or 2.5.1 kernel] problem solved ?!
Message-ID: <20020207015523.GA1267@oberon.ambre.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Club LinuX <clx@gaia.anet.fr>,
	Utilisateurs Debian =?iso-8859-1?Q?Fran=E7ais?= <debian-user-french@lists.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux oberon 2.4.13-ac8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[anglophobes, ne lisez pas la suite :-)]

Hi !

Le Mon, Feb 04, 2002 at 08:51:19PM +0100, Jose Luis Domingo Lopez a
écrit:
> One day I tried again to boot those "problematic" kernels from the
> same
> PC, now upgraded to Woody, and the problems appeared in the same
> places.
> One thing that I noticed is that Alan's 2.4.x-acY kernels had no
> problems booting where plain 2.4.x kernels failed.
thanks a lot for the tip !

I compiled a kernel from the "plain" 2.4.13 sources with the ac-8 patch
and it works fine.

haaa... my radeon works and I can play tuxracer; great !

more seriously, thanks to all the people making the ac kernel-variants.
Just one more -silly?- question: it seems -for me at least- that some
of the ac patches should be integrated in the kernel, why aren't they ?
(I repeat that ANY 2.4.17 variant I compiled won't even boot ! I'm not
talking about kernel panic here)
is my hardware so exotic ??

thanks again.

PS: it worked also with a 2.4.13-ac5 :-)
PPS: I don't mind to buils a few more kernel to identify which part(s)
of the ac patches is(are) responsible of this non-non-booting ;-)
situation but I need someone to guide me.
PPPS: I'll have some time in a week; tomorrow I go skiing 8-)
-- 
Stéphanie, Fabrice et Fiona	 -o)
stephanie.dupuis@free.fr	 /\\
fabrice.eudes@free.fr		_\_V
