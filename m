Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266716AbUFXR1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266716AbUFXR1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266714AbUFXR1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:27:41 -0400
Received: from havoc.gtf.org ([216.162.42.101]:7057 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266716AbUFXR0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:26:55 -0400
Date: Thu, 24 Jun 2004 13:25:41 -0400
From: David Eger <eger@havoc.gtf.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i8042 driver non-determinantly chokes mac on boot
Message-ID: <20040624172540.GA16782@havoc.gtf.org>
References: <20040624083910.GA14068@havoc.gtf.org> <20040624154127.GJ731@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624154127.GJ731@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 05:41:27PM +0200, Vojtech Pavlik wrote:
> On Thu, Jun 24, 2004 at 04:39:10AM -0400, David Eger wrote:
> > Though I'm not sure I even have an i8042 (I'm guessing no, as I run
> > on a Mac) the detection failure path has gone a little wonky in recent
> > kernels.  Half the time it times out with the following (as it ought, 
> > me thinks)
>  
> I suppose you should disable it, it really has no bussiness running on a
> Mac. Does it write anything when it also crashes?

Nope, just makes the machine stall out.

-dte
