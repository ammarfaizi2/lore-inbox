Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265454AbRGCRey>; Tue, 3 Jul 2001 13:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265478AbRGCRen>; Tue, 3 Jul 2001 13:34:43 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:43282 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265454AbRGCReZ>;
	Tue, 3 Jul 2001 13:34:25 -0400
Date: Tue, 3 Jul 2001 13:38:59 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cross-reference analysis reveals problems in 2.4.6pre9
Message-ID: <20010703133859.A26355@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010703131031.A25977@thyrsus.com> <200107031642.f63GgEG25604@snark.thyrsus.com> <29475.994179630@redhat.com> <20010703131031.A25977@thyrsus.com> <31556.994180939@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <31556.994180939@redhat.com>; from dwmw2@infradead.org on Tue, Jul 03, 2001 at 06:22:19PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> Upon further investigation, it seems I was mistaken. I apologise for my tone.

Accepted.  I wish more people had the grace you do, to apologize when you know 
you've been mistaken or unfair; it would make this list a better place.

> Momenco Ocelot boot flash device
> CONFIG_MTD_OCELOT
>   This enables access routines for the boot flash device and for the 
>   NVRAM on the Momenco Ocelot board. If you have one of these boards
>   and would like access to either of these, say 'Y'.

Incorporated.  I have also received mail from someone who can fill in the
new MIPS entries, so initial results from the posting are quite good.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The direct use of physical force is so poor a solution to the problem of
limited resources that it is commonly employed only by small children and
great nations.
	-- David Friedman
