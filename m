Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbUJ1U14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUJ1U14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbUJ1UXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:23:34 -0400
Received: from zeus.kernel.org ([204.152.189.113]:26605 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262878AbUJ1UWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:22:39 -0400
Message-Id: <200410282132.i9SLWhA3004709@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Chris Wedgwood <cw@f00f.org>
cc: Blaisorblade <blaisorblade_spam@yahoo.it>, akpm@osdl.org,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 7/7] uml: resolve symbols in back-traces 
In-Reply-To: Your message of "Thu, 28 Oct 2004 12:28:24 PDT."
             <20041028192824.GC851@taniwha.stupidest.org> 
References: <200410272223.i9RMNj921852@mail.osdl.org> <200410282034.21922.blaisorblade_spam@yahoo.it>  <20041028192824.GC851@taniwha.stupidest.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Oct 2004 17:32:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cw@f00f.org said:
> the emacs comments are gratuitous and completely pointless, they serve
> no useful purpose.  fwiw in my .emacs i have: 

Yeah, that's why I acked that particular change.

They're not completely pointless, they just cater to an individual's development
environment, and that sort of stuff should be in the environment, and not the
code.

				Jeff

