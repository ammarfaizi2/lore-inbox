Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUCJCLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 21:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUCJCLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 21:11:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:35538 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261435AbUCJCLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 21:11:15 -0500
Subject: Re: ppc/ppc64 and x86 vsyscalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <404E62B4.4000200@redhat.com>
References: <1078708647.5698.196.camel@gaston> <404D7AC3.9050207@redhat.com>
	 <1078830318.9746.3.camel@gaston>  <404E33A7.6070800@redhat.com>
	 <1078867992.9745.25.camel@gaston>  <404E62B4.4000200@redhat.com>
Content-Type: text/plain
Message-Id: <1078884483.9745.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 13:08:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Basically yes.  But you don't actually need the stub functions.  You
> just need a symbol table entry which can be arranged via an alias to any
> one of the real functions.


Ok, thanks.

Ben.



