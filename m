Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318946AbSHQAnu>; Fri, 16 Aug 2002 20:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318960AbSHQAnu>; Fri, 16 Aug 2002 20:43:50 -0400
Received: from waste.org ([209.173.204.2]:32652 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318946AbSHQAnu>;
	Fri, 16 Aug 2002 20:43:50 -0400
Date: Fri, 16 Aug 2002 19:47:44 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: henrique <henrique@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020817004744.GO5418@waste.org>
References: <200208161751.35895.henrique@cyclades.com> <Pine.LNX.4.44.0208162219110.1659-100000@sharra.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208162219110.1659-100000@sharra.ivimey.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 10:21:28PM +0100, Ruth Ivimey-Cook wrote:
> 
> Is there another way -- add a 'noise' device by connecting a PIO pin or 
> similar to suitable hardware? It shouldn't bee too hard to do as a one-off. 
> For example:
> 
>  [noise-diode]--[amplifier]--[schmidt-trigger-inverter]---[PIO INT pin]

Doable, but it obviously takes some tuning of the amplifier. And then
you'll have to run it through some whitening. 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
