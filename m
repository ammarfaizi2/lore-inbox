Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJIILs>; Wed, 9 Oct 2002 04:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJIILs>; Wed, 9 Oct 2002 04:11:48 -0400
Received: from [195.20.32.236] ([195.20.32.236]:22680 "HELO euro.verza.com")
	by vger.kernel.org with SMTP id <S261507AbSJIILq>;
	Wed, 9 Oct 2002 04:11:46 -0400
Date: Wed, 9 Oct 2002 10:17:17 +0200
From: Alexander Kellett <lypanov@kde.org>
To: Rob Landley <landley@trommello.org>
Cc: Jesse Pollard <pollard@admin.navo.hpc.mil>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021009081717.GA26073@groucho.verza.com>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	Jesse Pollard <pollard@admin.navo.hpc.mil>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <200210070856.07356.pollard@admin.navo.hpc.mil> <200210071903.g97J3VSs276692@pimout2-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210071903.g97J3VSs276692@pimout2-ext.prodigy.net>
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 10:03:16AM -0400, Rob Landley wrote:
> The frequency of mouse pointer stalls, and the worst case response time, is 
> probably something an automated benchmark could measure.  (Z-order's a 
> tricker problem because the window manager's involved, but mouse stalls are 
> EASY to cause.)

actually with low-latency, preempt and X's new silken mouse
stuff i haven't had any real mouse pointer stalls in a while.
well, apart from my maxtor drive stalling my entire system 
(vmstat included) for 2 seconds at a time when i get it to
pump its full 20mb/s (and yes, dma is enabled).

Alex
