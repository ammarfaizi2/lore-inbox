Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262530AbREUXMx>; Mon, 21 May 2001 19:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbREUXMn>; Mon, 21 May 2001 19:12:43 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:50166 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262530AbREUXM3>; Mon, 21 May 2001 19:12:29 -0400
Message-Id: <l03130307b72f4e2dc57a@[192.168.239.105]>
In-Reply-To: <15113.31946.548249.53012@gargle.gargle.HOWL>
In-Reply-To: <25499.990399116@redhat.com>
 <20010520165952.A9622@devserv.devel.redhat.com>
 <20010518113726.A29617@devserv.devel.redhat.com>
 <20010518114922.C14309@thyrsus.com>	<8485.990357599@redhat.com>
 <20010520111856.C3431@thyrsus.com>	<15823.990372866@redhat.com>
 <20010520114411.A3600@thyrsus.com>	<16267.990374170@redhat.com>
 <20010520131457.A3769@thyrsus.com>	<18686.990380851@redhat.com>
 <20010520164700.H4488@thyrsus.com>	<25499.990399116@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 22 May 2001 00:00:35 +0100
To: John Stoffel <stoffel@casc.com>, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Background to the argument about CML2 design philosophy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If you run into a case where you have a config which would work, but
>CML2 doesn't let you, why don't you fix the grammar instead of saying
>CML2 is wrong?  Let's not confuse these two issues as well.

Strongly agree.  Especially since I'm pushing for an explicit recognition
of the difference between a hard dependancy and a soft derivation.  The
latter can be over-ridden safely by someone who knows what he's after.  The
former will cause a miscompile.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


