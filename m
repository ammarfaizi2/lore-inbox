Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbWG1S5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbWG1S5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWG1S5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:57:19 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:23174 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1161236AbWG1S5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:57:18 -0400
Subject: Re: [patch 1/5] Add comments to the PDA structure to annotate
	offsets
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200607282052.20559.ak@suse.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <200607282041.38506.ak@suse.de>
	 <1154112207.6416.44.camel@laptopd505.fenrus.org>
	 <200607282052.20559.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 20:57:11 +0200
Message-Id: <1154113031.6416.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 20:52 +0200, Andi Kleen wrote:
> On Friday 28 July 2006 20:43, Arjan van de Ven wrote:
> > On Fri, 2006-07-28 at 20:41 +0200, Andi Kleen wrote:
> > > On Friday 28 July 2006 18:03, Arjan van de Ven wrote:
> > > > Subject: [patch 1/5] Add comments to the PDA structure to annotate
> > > > offsets From: Arjan van de Ven <arjan@linux.intel.com>
> > >
> > > So why exactly do you think these numbers need to be documented?
> > >
> > > If there is a reason there should be a comment in the code.
> > >
> > > Nobody should use fixed numbers, but always get the current ones
> > > from asm-offset
> >
> > the 40 one is a gcc ABI one (same offset as userland); 
> 
> Ah sounds ugly. Wasn't it possible to pass that as an option
> to gcc?

nope :(

