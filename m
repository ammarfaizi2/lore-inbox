Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284753AbRLHUZt>; Sat, 8 Dec 2001 15:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284759AbRLHUZk>; Sat, 8 Dec 2001 15:25:40 -0500
Received: from DIRTY-BASTARD.MIT.EDU ([18.241.0.136]:19461 "EHLO
	dirty-bastard.pthbb.org") by vger.kernel.org with ESMTP
	id <S284753AbRLHUZY>; Sat, 8 Dec 2001 15:25:24 -0500
Message-Id: <200112082022.fB8KMRJ27452@dirty-bastard.pthbb.org>
To: Sebastian Dr ge <sebastian.droege@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14/16 load reboots 
In-Reply-To: Your message of "Sat, 08 Dec 2001 18:07:48 +0100."
             <20011208180748.29711f73.sebastian.droege@gmx.de> 
Date: Sat, 08 Dec 2001 15:22:27 -0500
From: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is correct, I did a manaul .config and switched it to
PI. Didn't realize there was more than one setting *sigh*.

I'll try changing it with a make menuconfig.

Thanks!

PS> Why doesn't the CPU type *default* to whatever is listed
in /proc/cpunifo? I say only default ince I realize people
do build for other architectures.
