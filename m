Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTDQLHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 07:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTDQLHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 07:07:19 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:3570 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261308AbTDQLHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 07:07:18 -0400
Date: Thu, 17 Apr 2003 13:30:56 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Rik van Riel <riel@imladris.surriel.com>
Cc: Daniel Sheltraw <sheltraw@unm.edu>, linux-kernel@vger.kernel.org
Subject: Re: i386 kernel binaries
Message-ID: <20030417113056.GB16335@wind.cocodriloo.com>
References: <1050543109.3e9e0405ae425@webmail.unm.edu> <Pine.LNX.4.50L.0304162134000.18306-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0304162134000.18306-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 09:34:44PM -0400, Rik van Riel wrote:
> On Wed, 16 Apr 2003, Daniel Sheltraw wrote:
> 
> > Can one build a Linux Kernel that can be expected to run on all
> > i386 machines. If so how? Can you point me in the right direction?
> 
> Look at the -BOOT kernels from the various distributions.
> 
> The kernel on the installer media should run on all x86
> machines.
> 
> cheers,
> 
> Rik
> -- 
> Engineers don't grow up, they grow sideways.
> http://www.surriel.com/		http://kernelnewbies.org/

Try setting processor type to i386 and enabling FPU emulation. This
should cover even 386sx machines.

Greets, Antonio.
