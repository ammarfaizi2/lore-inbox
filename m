Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWH3Vsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWH3Vsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWH3Vsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:48:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932134AbWH3Vsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:48:52 -0400
Date: Wed, 30 Aug 2006 14:48:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: piet@bluelane.com
Cc: vgoyal@in.ibm.com, George Anzinger <george@wildturkeyranch.net>,
       Discussion
	 "list for crash utility usage, maintenance and development" 
	<crash-utility@redhat.com>,
       kgdb-bugreport@lists.sourceforge.net,
       Subhachandra Chandra <schandra@bluelane.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [Crash-utility] Patch to use gdb's bt in crash - works
 great with kgdb! - KGDB in Linus Kernel.
Message-Id: <20060830144822.3b8ffb9a.akpm@osdl.org>
In-Reply-To: <1156974093.29300.103.camel@piet2.bluelane.com>
References: <44EC8CA5.789286A@redhat.com>
	<20060824111259.GB22145@in.ibm.com>
	<44EDA676.37F12263@redhat.com>
	<1156966522.29300.67.camel@piet2.bluelane.com>
	<20060830204032.GD30392@in.ibm.com>
	<1156974093.29300.103.camel@piet2.bluelane.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006 14:41:32 -0700
Piet Delaney <piet@bluelane.com> wrote:

> My preference is for kgdb, like kexec, to become part of the 
> mainstream kernel as a configurable component.

Me too.  And I expect I could talk Linus into it if a) it works well on a
transport other-than-rs232 and b) the patches are nice and clean.

> Perhaps Andrew 
> could enumerate his issues.

a) and b) above.  Plus: I'd want to see a maintainance person or team who
respond promptly to email and who remain reasonably engaged with what's
going on in the mainline kernel.  Because if problems crop up (and they
will), I don't want to have to be the bunny who has to worry about them...

