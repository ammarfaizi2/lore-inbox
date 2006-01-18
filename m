Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWARANt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWARANt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWARANt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:13:49 -0500
Received: from solarneutrino.net ([66.199.224.43]:17157 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932342AbWARANs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:13:48 -0500
Date: Tue, 17 Jan 2006 19:12:53 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060118001252.GB821@tau.solarneutrino.net>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local> <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org> <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org> <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com> <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This machine experienced another random reboot today, nothing in the
logs or on the console etc.  This is the 3rd time now since I upgraded
from 2.6.11.3.  Is there any way to debug something like this?  I'm
fairly certain it's not hardware-related.  Might this have something to
do with the st problem?

Thanks,
-ryan
