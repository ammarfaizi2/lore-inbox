Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTATTil>; Mon, 20 Jan 2003 14:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTATTik>; Mon, 20 Jan 2003 14:38:40 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6148 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266805AbTATTib>;
	Mon, 20 Jan 2003 14:38:31 -0500
Date: Sun, 19 Jan 2003 23:04:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/3) NUMA aware scheduler
Message-ID: <20030119220421.GA27317@elf.ucw.cz>
References: <2050000.1042741643@flay> <004001c2bd98$3854dec0$645e2909@atheurer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004001c2bd98$3854dec0$645e2909@atheurer>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> One of the reasons we probably have not had much interest in numa patches is
> that numa systems are not that prevailent.  However, numa-like qualites are
> showing up in commonly available systems, and I believe we can take
> advantage of policies that these patches, such as numa scheduler provide.
> Does anyone have any other ideas where numa like qualities lie?  x86-64?

Yep, x86-64 SMP systems are in fact NUMA systems that don't penalize
remote memory *that* badly.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
