Return-Path: <linux-kernel-owner+w=401wt.eu-S1422836AbWLUIEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422836AbWLUIEo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWLUIEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:04:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47411 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422836AbWLUIEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:04:43 -0500
Date: Thu, 21 Dec 2006 00:04:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [GIT PATCH] PCI patches for 2.6.20-rc1
Message-Id: <20061221000410.6db0b5af.akpm@osdl.org>
In-Reply-To: <20061221073609.GA6989@colo.lackof.org>
References: <20061220200142.GB1698@kroah.com>
	<20061221073609.GA6989@colo.lackof.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 00:36:09 -0700
Grant Grundler <grundler@parisc-linux.org> wrote:

> On Wed, Dec 20, 2006 at 12:01:42PM -0800, Greg KH wrote:
> > Here are some PCI patches for 2.6.20-rc1
> > 
> > They contain a number of PCI quirk fixes and some PCI hotplug driver
> > fixes and changes, and some other stuff that is detailed below.
> 
> Any reasons why the Documentation/pci.txt patch isn't included?
> Did I botch something?

I saw about 88,000 of them fly past, none of which looked like a final patch
(sane Subject:, changelog and s-o-b).

> Should I resubmit?

s/re// ;)

Yes please.
