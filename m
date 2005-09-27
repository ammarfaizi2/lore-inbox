Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVI0UM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVI0UM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVI0UM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:12:57 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:50186 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750914AbVI0UM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:12:56 -0400
Date: Tue, 27 Sep 2005 15:30:55 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Uml showstopper bugs for 2.6.14
Message-ID: <20050927193055.GA30451@ccure.user-mode-linux.org>
References: <200509271846.51804.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509271846.51804.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 06:46:50PM +0200, Blaisorblade wrote:
> Jeff, have you any further notes to add?

Agree.

I have one more to add - that UML/x86_64 doesn't run with CONFIG_FRAME_POINTER
disabled.

				Jeff
