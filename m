Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267229AbUBMVZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267230AbUBMVZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:25:05 -0500
Received: from ns.suse.de ([195.135.220.2]:41600 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267229AbUBMVZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:25:01 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling
References: <20040213205743.GA30245@MAIL.13thfloor.at.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Feb 2004 22:25:00 +0100
In-Reply-To: <20040213205743.GA30245@MAIL.13thfloor.at.suse.lists.linux.kernel>
Message-ID: <p73n07my8nn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> 	[ARCH sparc64/sparc]    failed.     failed.
> 	[ARCH x86_64/x86_64]    failed.     succeeded.

Your test methology must be broken. 2.4.25rc2 cross compiles 
just fine here from i386 to x86_64. 

-Andi
