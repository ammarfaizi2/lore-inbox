Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVCCOb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVCCOb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 09:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVCCOb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 09:31:29 -0500
Received: from gate.in-addr.de ([212.8.193.158]:24744 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261764AbVCCObZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 09:31:25 -0500
Date: Thu, 3 Mar 2005 15:31:33 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303143133.GA14495@marowsky-bree.de>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302225846.GK17584@marowsky-bree.de> <20050302232349.GA9743@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050302232349.GA9743@kroah.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-03-02T15:23:49, Greg KH <greg@kroah.com> wrote:

> > This could be improved: _All_ new features have to go through -mm first
> > for a period (of whatever length) / one cycle. 2.6.x only directly picks
> > up "obvious" bugfixes, and a select set of features which have ripened
> > in -mm. 2.6.x-pre releases would then basically "only" clean up
> > integration bugs.
> 
> This is the way things work today already.  The only exception being the
> networking code, but hey, networking's always been special :)

That's exactly what I'm saying. It already works this way, w/o
misleading the users and attaching confusing meaning to minor revision
numbers. It could do with being more clearly advertised and sticked to,
but that's about it.

Don't confuse more. People are already way to confused on their own.

If anything, if we expect a release to have ... interesting
side-effects, Linus will find just the funny words for the release notes
to say so ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

