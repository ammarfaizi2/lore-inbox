Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTDPVzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDPVzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:55:51 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:62081 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S261760AbTDPVzu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:55:50 -0400
From: root@mauve.demon.co.uk
Message-Id: <200304162205.XAA15178@mauve.demon.co.uk>
Subject: Re: my dual channel DDR 400 RAM won't work on any linux distro
To: rwhite@casabyte.com (Robert White)
Date: Wed, 16 Apr 2003 23:05:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGCEMNCHAA.rwhite@casabyte.com> from "Robert White" at Apr 16, 2003 01:53:34 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I had one-hell of a problem myself relating to memory on my new cutting edge
> motherboard.  The problem, it turned out, had everything to do with the
> motherboard and the often marginal quality of the ram.  Much investigation
> revealed that there were only a few manufacturers of ram that the MoBoard
> would "support"
> 
> In lay speak, I could put any damn thing I wanted into the first slot, but
> anything I did with the second and subsequent slots went all haywire.
> 
> The BS layman's speak they gave me at the store was that they had seen a lot
> of cases where having "double sided SIMMs" (they were oh-so-usefully
> classifying the memory based on whether there were chips on just one side,
> or on both sides of the circuit card 8-) in the second and subsequent slots
> never worked.

This has a little basis in fact.

"Double sided SIMMs" can have higher capacitances on the data lines, as there
are more pins connected to the socket.
This means more loading, especially at high speed.

Add in marginal designs, and it can make a difference.

