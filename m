Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267134AbTGGQDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267136AbTGGQDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:03:32 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:24218 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S267134AbTGGQDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:03:30 -0400
Date: Mon, 7 Jul 2003 09:18:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] two PPC patches for 2.5.73
Message-ID: <20030707161803.GC17433@ip68-0-152-218.tc.ph.cox.net>
References: <20030706023922.52c2806a.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706023922.52c2806a.colin@colino.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 06, 2003 at 02:39:22AM +0200, Colin Leroy wrote:

> here are two patches for kernel 2.5.73.
> compile.diff is needed for the kernel to compile.
> time.diff fixes uptime being wrong; I hope it's correct.

In the future, PPC changes should be sent to the linuxppc-dev list at
lists.linuxppc.org, and this has already been fixed in the linuxppc-2.5
tree (which has all of the changes ready to goto Linus, as well as stuff
being worked on for PPC, etc).  This tree is at
bk://ppc.bkbits.net/linuxppc-2.5 or
rsync://source.mvista.com/linuxppc-2.5

-- 
Tom Rini
http://gate.crashing.org/~trini/
