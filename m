Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVCLD5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVCLD5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVCLD5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:57:18 -0500
Received: from peabody.ximian.com ([130.57.169.10]:59321 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261851AbVCLD5H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:57:07 -0500
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino
	speedstep even more broken than in 2.6.10
From: Adam Belay <abelay@novell.com>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cpufreq@ZenII.linux.org.uk
In-Reply-To: <20050311173517.7fe95918.akpm@osdl.org>
References: <20050311202122.GA13205@fefe.de>
	 <20050311173517.7fe95918.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 22:54:18 -0500
Message-Id: <1110599659.12485.279.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 17:35 -0800, Andrew Morton wrote:
> Felix von Leitner <felix-linuxkernel@fefe.de> wrote:
> >
> > Finally Centrino SpeedStep.
> > I have a "Intel(R) Pentium(R) M processor 1.80GHz" in my notebook.
> > Linux does not support it.  This architecture has been out there for
> > months now, and there even was a patch to support it posted here a in
> > October last year or so.  Linux still does not include it.  Until
> > 2.6.11-rc4-bk8 or so, the old patched file from back then still worked.
> > Now it doesn't.  Because some interface changed.  Now what?  Using a
> > Centrino notebook without CPU throttling is completely out of the
> > question.  Linux might as well not boot on it at all.
> 
> Could you please dig out the old patch, send it?

Why not use ACPI for CPU scaling?

Thanks,
Adam


