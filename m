Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbTDCSR7 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261526AbTDCSR7 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:17:59 -0500
Received: from ns.suse.de ([213.95.15.193]:4113 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261514AbTDCSR4 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 13:17:56 -0500
Date: Thu, 3 Apr 2003 20:29:22 +0200
From: Andi Kleen <ak@suse.de>
To: mikpe@csd.uu.se
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 x86_64 oops when swapoff via IA32 emulation
Message-ID: <20030403182922.GB2232@wotan.suse.de>
References: <16012.19359.948383.217572@enequist.it.uu.se> <20030403151642.GB2062@wotan.suse.de> <16012.26449.528594.682130@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16012.26449.528594.682130@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 06:54:41PM +0200, mikpe@csd.uu.se wrote:
> Andi Kleen writes:
>  > On Thu, Apr 03, 2003 at 04:56:31PM +0200, mikpe@csd.uu.se wrote:
>  > > I got this oops from swapoff when shutting down 2.5.66 on
>  > > x86_64 with 32-bit user-space (RH8.0). This was from the first
>  > > run with 2.5.66, I wasn't able to reproduce it in later runs.
>  > 
>  > Is this on the Simulator or on a real Opteron/Athlon64? 
> 
> Simics.

Don't know what it could be then. Can you reproduce it ? 

-Andi
