Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWEPVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWEPVOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWEPVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:14:46 -0400
Received: from thunk.org ([69.25.196.29]:44477 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750855AbWEPVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:14:45 -0400
Date: Tue, 16 May 2006 17:14:30 -0400
From: Theodore Tso <tytso@mit.edu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-ID: <20060516211430.GA9571@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060516174413.GI10077@stusta.de> <20060516122731.6ecbdeeb.akpm@osdl.org> <20060516193956.GS10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516193956.GS10077@stusta.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 09:39:56PM +0200, Adrian Bunk wrote:
> Since you replied to this patch:
> Who is the subsystem maintainer for jbd?

I'd suggest sending mail to ext2-devel@lists.sourceforge.net.  There's
actually a lot of work going on right now with both ext3 and jbd right
now, including finally getting the 64-bit support for jbd merged in.

						- Ted
