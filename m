Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTHWMhk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTHWMhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:37:40 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:13293 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264793AbTHWMgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:36:25 -0400
Date: Sat, 23 Aug 2003 14:36:22 +0200 (MEST)
Message-Id: <200308231236.h7NCaMl0018383@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, lkml@kcore.org
Subject: Re: Pentium-M?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003 13:50:02 +0200, Jan De Luyck <lkml@kcore.org> wrote:
>Just a short question. For the Pentium-M as used in the centrino platform, 
>what do I select in the 2.6.0-test4 kernel configuration as the CPU?
>
>I figure it's not a PIV, but is it a P3? Or is it something special?

The P-M core is PIII, to which SSE2, some P4-like model-specific
registers, and (it seems) a P4 bus were added.

For now, treat it simply as a PIII.

/Mikael
