Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbUJ0Rhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbUJ0Rhw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUJ0Rfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:35:39 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42655 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262520AbUJ0R0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:26:07 -0400
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <417FC96B.8030402@grupopie.com>
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>
	 <417FB7BA.9050005@grupopie.com> <1098892587.8313.5.camel@krustophenia.net>
	 <417FC96B.8030402@grupopie.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098894142.4304.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 17:22:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-27 at 17:14, Paulo Marques wrote:
> > Why don't you try the VIA EPIA mini-ITX boards?  These are designed for
> > low power applications like yours.  I am running the M-6000 which has a
> > fanless 600Mhz C3 processor, the newer fanless models run at 1Ghz.  And,
> > on top of that they support speed scaling so you can slow it down even
> > more.
> 
> Yes, we tried those, but floating point calculations completely kill the 
> performance on those boards.

You want Geode/NX or Pentium-M ITX boards for that (or the low power
'Shelton' board although you may need to import that since its only sold
in "poor countries")

Agree with you on pricing though.

