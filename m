Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262988AbUKRVX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbUKRVX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUKRVVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:21:43 -0500
Received: from mail.suse.de ([195.135.220.2]:16086 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262978AbUKRVUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:20:48 -0500
Date: Thu, 18 Nov 2004 21:46:02 +0100
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: discuss@x86-64.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: Re: [discuss] [PATCH 2.6.10-rc2] x86_64: only single-step into signal handlers if the tracer asked for it
Message-ID: <20041118204602.GB31342@wotan.suse.de>
References: <200411150203.iAF23Trb024677@hera.kernel.org> <20041118154219.GJ4583@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118154219.GJ4583@smtp.west.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 08:42:19AM -0700, Tom Rini wrote:
> On Mon, Nov 15, 2004 at 08:56:31AM +0000, torvalds@ppc970.osdl.org wrote:
> 
> > ChangeSet 1.2159, 2004/11/15 00:56:31-08:00, torvalds@ppc970.osdl.org
> > 
> > 	x86: only single-step into signal handlers if the tracer
> > 	asked for it.
> 
> x86_64 looks to have the same issue.  But I deferr to the experts (and
> hope this isn't a dupe).

Looks good, thanks.

-Andi
