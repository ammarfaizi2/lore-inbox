Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267428AbUHJFSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267428AbUHJFSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUHJFSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:18:12 -0400
Received: from waste.org ([209.173.204.2]:7390 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267428AbUHJFSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:18:10 -0400
Date: Tue, 10 Aug 2004 00:17:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-kernel@vger.kernel.org,
       vonbrand@inf.utfsm.cl
Subject: Re: Linux Kernel bug report (includes fix)
Message-ID: <20040810051747.GC5414@waste.org>
References: <200408091420.i79EKBEu010574@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091420.i79EKBEu010574@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 04:20:11PM +0200, Joerg Schilling wrote:
> >From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> >> As you don't know how kernel/user interfaces are handled, it would be wise for 
> >> you to keep quiet.....
> 
> >Linux kernel include files are not meant to be used by user
> >applications. He's perfectly correct. Glibc has its own exported set.
> >This is intentional to seperate internals from user space.
> 
> You should know that GLIBc is unrelated to the Linux kernel interfaces we are> talking about. Start using serious arguments please.

If you had any inkling, you'd have caught on by now that using kernel
headers in userspace programs has been deprecated for about six years.

They don't compile in userspace because it's not supported. Phased
out, outmoded, obsolete, passe, renounced, defunct, disused,
abandoned. The plumage doesn't enter into it. It's stone dead.

-- 
Mathematics is the supreme nostalgia of our time.
