Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbSKWQQm>; Sat, 23 Nov 2002 11:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSKWQQl>; Sat, 23 Nov 2002 11:16:41 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:16133 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266997AbSKWQQl>; Sat, 23 Nov 2002 11:16:41 -0500
Date: Sat, 23 Nov 2002 16:23:46 +0000
From: John Levon <levon@movementarian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder
Message-ID: <20021123162346.GB30167@compsoc.man.ac.uk>
References: <20021123023513.GC83190@compsoc.man.ac.uk> <13864.1038019400@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13864.1038019400@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18Fd4M-000Afr-00*LOUmyQfW.jY* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2002 at 01:43:20PM +1100, Keith Owens wrote:

> Only if you assume that the .text is at a known offset from the start
> of the module.  There are multiple programs that need to know where
> each section really is, instead of making assumptions about how a
> module is laid out.

Yes, sorry, that is what I meant.

regards
john

-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
