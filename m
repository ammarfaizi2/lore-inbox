Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFNPUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFNPUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFNPUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:20:03 -0400
Received: from iron.pdx.net ([207.149.241.18]:54436 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S261155AbVFNPTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:19:51 -0400
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
References: <20050605204645.A28422@jurassic.park.msu.ru>
	 <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
	 <20050610184815.A13999@jurassic.park.msu.ru>
	 <200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 08:19:42 -0700
Message-Id: <1118762382.9161.3.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 22:47 +0200, Andreas Koch wrote:
> On Friday 10 June 2005 16:48, Ivan Kokshaysky wrote:
> > I'm still not sure if it boots though...
> 
> It does :-))
> 
> And the devices on the dock appear to be working, too! I could only test the 
> USB ports (my wife has currently taken posession of our FireWire MP3 player), 
> but according to the attached log, the mappings look sensible.
> If you'd like me to perform other tests, let me know.
> 
>From this comment it appears that the last patch does work?  Just
curious if this thread it dead or if there is more work to be done.

Sean


