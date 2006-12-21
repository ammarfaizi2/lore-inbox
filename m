Return-Path: <linux-kernel-owner+w=401wt.eu-S1422979AbWLURUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422979AbWLURUR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWLURUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:20:17 -0500
Received: from colo.lackof.org ([198.49.126.79]:58667 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422979AbWLURUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:20:15 -0500
Date: Thu, 21 Dec 2006 10:20:13 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, Greg KH <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [GIT PATCH] PCI patches for 2.6.20-rc1
Message-ID: <20061221172013.GA23590@colo.lackof.org>
References: <20061220200142.GB1698@kroah.com> <20061221073609.GA6989@colo.lackof.org> <20061221000410.6db0b5af.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221000410.6db0b5af.akpm@osdl.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 12:04:10AM -0800, Andrew Morton wrote:
> On Thu, 21 Dec 2006 00:36:09 -0700
> Grant Grundler <grundler@parisc-linux.org> wrote:
> > Any reasons why the Documentation/pci.txt patch isn't included?
> > Did I botch something?
> 
> I saw about 88,000 of them fly past, none of which looked like a final patch

Isn't that normal for patches? :)

> (sane Subject:, changelog and s-o-b).

This is the 'droid you are looking for:
	http://lkml.org/lkml/2006/12/18/15

AFAIK, the only thing missing is the s-o-b line from gregkh
and/or Hidetoshi Seto (who should also get credit for some
of the new content). But I think they could reply to that
email with their s-o-b line.

> > Should I resubmit?
> 
> s/re// ;)
> 
> Yes please.

thanks!
grant
