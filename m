Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUH1DgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUH1DgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 23:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUH1DgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 23:36:00 -0400
Received: from jib.isi.edu ([128.9.128.193]:55688 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S263664AbUH1Df6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 23:35:58 -0400
Date: Fri, 27 Aug 2004 20:35:52 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: QuantumG <qg@biodome.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reverse engineering pwcx
Message-ID: <20040828033552.GN24018@isi.edu>
References: <412FD751.9070604@biodome.org> <20040828012055.GL24018@isi.edu> <20040828014931.GM24018@isi.edu> <412FF888.8090307@biodome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412FF888.8090307@biodome.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.28, QuantumG wrote:
> Craig Milo Rogers wrote:
> 
> >	Hmmm... a poster on Slashdot claims that entropy measurements
> >imply that the pwcx code is interpolating rather that truly
> >decompressing.  Again, that's integer math and table lookups.
> > 
> >
> 
> http://www.amazon.com/exec/obidos/tg/detail/-/B00005R098/102-7619892-0201738?v=glance
> 
> claims that the Logitech Quickcam Pro 3000 is a "True 640 x 480 
> resolution video capture" which is now clearly false.

	If the "now clearly false" is meant to be a consequence of the
entropy measurements poster I referred to, I wouldn't jump the gun.
On reflection, it's entirely natural for a decompressed stream to
examine less entropy than the corresponding compressed stream!

					Craig Milo Rogers
