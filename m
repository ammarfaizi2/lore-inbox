Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423867AbWKIPOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423867AbWKIPOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423875AbWKIPOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:14:23 -0500
Received: from ns1.suse.de ([195.135.220.2]:1421 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423867AbWKIPOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:14:22 -0500
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] shorten the x86_64 boot setup GDT to what the comment says
Date: Thu, 9 Nov 2006 14:13:21 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, sct@redhat.com,
       herbert@gondor.apana.org.au, xen-devel@lists.xensource.com
References: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0611082144410.17812@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091413.21415.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Stephen Tweedie has written up a patch to fix the Xen side and will be
> submitting that to those folks. But that doesn't excuse the GDT limit
> being a magnitude too big.

Added thanks

-Andi
