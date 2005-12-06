Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbVLFUnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbVLFUnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVLFUnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:43:41 -0500
Received: from solarneutrino.net ([66.199.224.43]:43525 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1030231AbVLFUnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:43:40 -0500
Date: Tue, 6 Dec 2005 15:43:37 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051206204336.GA12248@tau.solarneutrino.net>
References: <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net> <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com> <20051202180326.GB7634@tau.solarneutrino.net> <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> <20051202194447.GA7679@tau.solarneutrino.net> <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com> <20051206160815.GC11560@tau.solarneutrino.net> <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 08:31:43PM +0000, Hugh Dickins wrote:
> Thanks for the further report.  And you had my st.c patch in along
> with 2.6.14.3, but it still happened, very much like before (except the
> latter errors, general protection fault onwards - but once we get into
> using one page for two uses at the same time, anything can go wrong).
> 
> I've been staring and thinking, but no inspiration yet.

That's correct, thanks for looking.  Let me know if there's anything I
could do get more information.

-ryan
