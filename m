Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316380AbSEOMNR>; Wed, 15 May 2002 08:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316381AbSEOMNQ>; Wed, 15 May 2002 08:13:16 -0400
Received: from jp.jh-inst.cas.cz ([147.231.28.95]:54400 "EHLO
	jp.jh-inst.cas.cz") by vger.kernel.org with ESMTP
	id <S316380AbSEOMNP>; Wed, 15 May 2002 08:13:15 -0400
Date: Wed, 15 May 2002 14:13:13 +0200
From: Jiri Pittner <jiri@dirac.jh-inst.cas.cz>
Message-Id: <200205151213.g4FCDDhx023863@jp.jh-inst.cas.cz>
To: linux-kernel@vger.kernel.org
Subject: problems with IRDA under 2.4.18 (SUSE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear kernel developers,

I suspect that there might be some bug in the IRDA functionality
in 2.4.18. The IRDA-ircomm communication already worked on my UMAX
notebook - Motorola phone under the original 2.4.16 kernel from SUSE7.3
distribution, but after update to SUSE8.0 with their original 2.4.18 
kernel I do not get even irdadump working. The procedure I used was the same
in both cases and followed the Infrared-HOWTO.
I do not have an idea where the bug might be, it can be in the userspace IRDA utilities as well. I just saw that there were some changes in the kernel
in the IRDA part between 2.4.16 and 2.4.18 and maybe something went wrong.

Best regards,

Jiri Pittner
