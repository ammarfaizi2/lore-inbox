Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUJATSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUJATSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUJATSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:18:34 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:50632 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266183AbUJATS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:18:28 -0400
Message-ID: <12c511ca04100112181a252c92@mail.gmail.com>
Date: Fri, 1 Oct 2004 12:18:25 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: tony.luck@intel.com
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [ia64 patch 2.6.9-rc3] build: ccache/distcc fix for ia64
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, kai@germaschewski.name, sam@ravnborg.org
In-Reply-To: <16733.12213.315295.653547@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041001101040.GA25104@elte.hu>
	 <16733.12213.315295.653547@napali.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2004 03:21:41 -0700, David Mosberger
<davidm@napali.hpl.hp.com> wrote:
> >>>>> On Fri, 1 Oct 2004 12:10:40 +0200, Ingo Molnar <mingo@elte.hu> said:
> 
>   Ingo> the (tested) patch below fixes ccache/distcc-assisted building
>   Ingo> of the ia64 tree. (CC is "ccache distcc gcc" in that case, not
>   Ingo> a simple one-word "gcc" - this confused the check-gas and
>   Ingo> toolchain-flags scripts.)
> 
> Looks fine to me.
> 
> Thanks,
> 
>         --david

Me too ... applied (though I would have found this patch faster if you
had copied
the linux-ia64@vger.kernel.org list).

-Tony
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
