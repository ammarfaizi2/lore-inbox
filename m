Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbTHYTSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbTHYTSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:18:50 -0400
Received: from codepoet.org ([166.70.99.138]:1947 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262204AbTHYTSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:18:48 -0400
Date: Mon, 25 Aug 2003 13:18:48 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Luca Montecchiani <luca.montecchiani@teamfab.it>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@hera.kernel.org>
Subject: Re: linux-2.4.22 released
Message-ID: <20030825191848.GA5879@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Luca Montecchiani <luca.montecchiani@teamfab.it>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@hera.kernel.org>
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030825132358.GC14108@merlin.emma.line.org> <3F4A336A.9060804@teamfab.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4A336A.9060804@teamfab.it>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 25, 2003 at 06:03:54PM +0200, Luca Montecchiani wrote:
> Matthias Andree wrote:
> >On Mon, 25 Aug 2003, Marcelo Tosatti wrote:
> >
> >
> >>- 2.4.22-rc4 was released as 2.4.22 with no changes.
> >
> >
> >What are the plans for 2.4.23? XFS merge perhaps <hint>?
> 
> What about the two IDE patch from Erik B. Andersen ?
> 
> [PATCH] Backport recent IDE updates, take 2
> [PATCH] Fix cdrom error handling in 2.4

The cdrom fix is already in 2.4.22.  The IDE update would
be a good candidate for 2.4.23.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
