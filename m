Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSCKBsB>; Sun, 10 Mar 2002 20:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293459AbSCKBrv>; Sun, 10 Mar 2002 20:47:51 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:52489
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S293448AbSCKBre>; Sun, 10 Mar 2002 20:47:34 -0500
Date: Mon, 11 Mar 2002 02:47:32 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH SIS IDE] sis5513.c v0.13 final against 2.4.19-pre2
Message-ID: <20020311024732.C32392@bouton.inet6-interne.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, mailed Marcelo, Andre and Alan but forgot to CC lkml, here it's done...

Hi,

as no bugreport came in since last post, here's a patch against 2.4.19-pre2
for the SiS IDE driver. It brings ATA16 and ATA33 chipset families support
as well as ATA66 and ATA100 bugfixes. Configure.help and MAINTAINERS are
updated.
This is roughly the same driver than the one in 2.4.19-pre2-ac2
(verbose debug messages deactivated and some cleanups).

I consider it to large (35276 bytes) for lkml posting, so
here's a link to it:
http://inet6.dyn.dhs.org/sponsoring/sis5513/sis.patch.20020311_1
mirror available at:
http://gyver.homeip.net/sis5513/sis.patch.20020311_1

Please apply,

LB.

PS: Alan, a patch against 2.4.19-pre2-ac4 is coming RSN.
