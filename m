Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWGJNVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWGJNVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWGJNVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:21:22 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63719 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751393AbWGJNVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:21:22 -0400
Subject: Re: Linux v2.6.18-rc1
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Reply-To: will_schmidt@vnet.ibm.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1152441242.4128.33.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <pan.2006.07.07.15.41.35.528827@us.ibm.com>
	 <1152441242.4128.33.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Mon, 10 Jul 2006 08:21:12 -0500
Message-Id: <1152537672.28828.4.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-07 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > We've got a ppc64 machine that won't boot with this due to an IDE error.
> 
> What machine precisely ?

I see a slightly more verbose version on a JS20 blade. 

hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt



> 
> > [snip]
> > Freeing unused kernel memory: 256k freed
> >  running (1:2) /init autobench_args: ABAT:1152213829
> > 
> > creating device nodes .hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

