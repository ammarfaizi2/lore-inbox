Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbUJ2Ac5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUJ2Ac5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbUJ2AYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:24:07 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:14503 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263204AbUJ2AU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:20:27 -0400
Date: Thu, 28 Oct 2004 17:19:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Re: [patch 7/7] uml: resolve symbols in back-traces
Message-ID: <20041029001950.GC12434@taniwha.stupidest.org>
References: <200410272223.i9RMNj921852@mail.osdl.org> <200410282132.i9SLWhA3004709@ccure.user-mode-linux.org> <20041028205136.GA1888@taniwha.stupidest.org> <200410290144.11700.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410290144.11700.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:44:11AM +0200, Blaisorblade wrote:

> ??? I don't understand you well. If there are compile-commands for
> emacs, they're broken too - using make namefile.o ARCH=um is the
> kernel universal solution.

consider a load-able module for uml ... the compile command might be
to build and load the module into a running UML instance...  for some
people that's a pretty nice working module where you dont have to
leave your editor to boot/run test things
