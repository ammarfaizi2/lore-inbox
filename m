Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTLNJC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 04:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265368AbTLNJC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 04:02:59 -0500
Received: from dp.samba.org ([66.70.73.150]:36033 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265367AbTLNJC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 04:02:58 -0500
Date: Sun, 14 Dec 2003 19:58:43 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: prepare_to_wait/waitqueue_active issues in 2.6
Message-ID: <20031214085842.GP17683@krispykreme>
References: <20031214034059.GL17683@krispykreme> <20031214035356.GM17683@krispykreme> <Pine.LNX.4.58.0312132024270.14336@home.osdl.org> <20031214052330.GN17683@krispykreme> <Pine.LNX.4.58.0312132130270.14336@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312132130270.14336@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I'll go back to my lazy ways in 2.7.x, I'm sure.

Phew, you had me worried for a while :)

> Anyway, even if I think the patch is "obviously correct", can you do me a
> favor and test it on the load that you've seen failing? Just to be anal.

Sure, we'll run with this patch and report back.

Anton
