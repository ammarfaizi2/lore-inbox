Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTBUX1w>; Fri, 21 Feb 2003 18:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267801AbTBUX1w>; Fri, 21 Feb 2003 18:27:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:61907 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267646AbTBUX1w>;
	Fri, 21 Feb 2003 18:27:52 -0500
Date: Fri, 21 Feb 2003 15:21:53 -0800 (PST)
Message-Id: <20030221.152153.33801109.davem@redhat.com>
To: pavel@suse.cz
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       ak@suse.de
Subject: Re: ioctl32 consolidation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030221113428.GF24049@atrey.karlin.mff.cuni.cz>
References: <20030220223119.GA18545@elf.ucw.cz>
	<20030220224433.GV9800@gtf.org>
	<20030221113428.GF24049@atrey.karlin.mff.cuni.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Fri, 21 Feb 2003 12:34:29 +0100

   > I do not know if it is too late in 2.5.x to begin this work, however.
   > We _are_ in a feature freeze...  I suppose it is up to the consensus of
   > arch maintainers, because it [obviously] does not affect ia32.
   
   Actually Andi asked me to do the work. Dave, is it okay with you? What
   about other maintainers?

I'm totally fine with it.
