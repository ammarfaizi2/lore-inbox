Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVCVAf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVCVAf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVCVAel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:34:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:37766 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbVCVAcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:32:31 -0500
Date: Mon, 21 Mar 2005 16:32:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adam Belay <abelay@novell.com>
Cc: felix-linuxkernel@fefe.de, linux-kernel@vger.kernel.org,
       cpufreq@ZenII.linux.org.uk
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino
 speedstep even more broken than in 2.6.10
Message-Id: <20050321163225.4af1c169.akpm@osdl.org>
In-Reply-To: <1110599659.12485.279.camel@localhost.localdomain>
References: <20050311202122.GA13205@fefe.de>
	<20050311173517.7fe95918.akpm@osdl.org>
	<1110599659.12485.279.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay <abelay@novell.com> wrote:
>
> On Fri, 2005-03-11 at 17:35 -0800, Andrew Morton wrote:
> > Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
> > >
> > > Finally Centrino SpeedStep.
> > > I have a "Intel(R) Pentium(R) M processor 1.80GHz" in my notebook.
> > > Linux does not support it.  This architecture has been out there for
> > > months now, and there even was a patch to support it posted here a in
> > > October last year or so.  Linux still does not include it.  Until
> > > 2.6.11-rc4-bk8 or so, the old patched file from back then still worked.
> > > Now it doesn't.  Because some interface changed.  Now what?  Using a
> > > Centrino notebook without CPU throttling is completely out of the
> > > question.  Linux might as well not boot on it at all.
> > 
> > Could you please dig out the old patch, send it?
> 
> Why not use ACPI for CPU scaling?
> 

Felix, did you try this?

