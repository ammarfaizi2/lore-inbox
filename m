Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbTIZI3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIZI3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 04:29:24 -0400
Received: from adsl173-178.dsl.uva.nl ([146.50.173.178]:1998 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S261442AbTIZI3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 04:29:23 -0400
Date: Fri, 26 Sep 2003 10:29:16 +0200
From: Frank v Waveren <fvw@var.cx>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: How do I access ioports from userspace?
Message-ID: <20030926082916.GA16318@var.cx>
References: <20030926073407.GA15797@var.cx> <1064562042.28617.23.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064562042.28617.23.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 09:40:42AM +0200, Benjamin Herrenschmidt wrote:
> > in[bwl]/out[bwl] are available on a lot more than just x86. Mind you, the
> > mechanisms are subtly different. Then again, if you're using direct hardware
> > access you're not going for portability anyway.
> Are they from userland ? I doubt it...
Have a look at your include files, they're defined everywhere, and defined
to something useful almost everywhere.

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|dse.nl] ICQ#10074100               1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
