Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266617AbUHVJsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266617AbUHVJsf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 05:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUHVJsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 05:48:35 -0400
Received: from darwin.snarc.org ([81.56.210.228]:4577 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S266617AbUHVJsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 05:48:32 -0400
Date: Sun, 22 Aug 2004 11:48:31 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 use simplified mmenonics
Message-ID: <20040822094831.GB2589@snarc.org>
References: <20040821222318.GA32229@snarc.org> <1093140048.10506.277.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093140048.10506.277.camel@gaston>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 12:00:49PM +1000, Benjamin Herrenschmidt wrote:
> Oh well.. I've got quite used to tweaking rlwinm directly but I suppose
> it's more clear for others to go to clrrwi. I see no obvious problem
> though I haven't double checked the bit counts, I suppose you got the
> substraction right everywhere but you know... it's always on the trivial
> things that we make the nasty mistakes ;)

Sure, trivial mistakes are the worst !
I have verified already 2 times, but that would not hurt a 3 times with
a different look :)

> I'll look again when I'm back (I'm away for the week-end)

Thanks,

-- 
Tab
