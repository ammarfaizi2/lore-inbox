Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTHVMux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbTHVMua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:50:30 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:4048
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263202AbTHVMai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 08:30:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "P. Christeas" <p_christ@hol.gr>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: SCO's "proof"
Date: Fri, 22 Aug 2003 22:37:06 +1000
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200308221236.46023.p_christ@hol.gr>
In-Reply-To: <200308221236.46023.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308222237.06432.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 August 2003 19:36, P. Christeas wrote:
> >On Fri, 22 Aug 2003, Sulaiman Alhasawi wrote:
> >> >>>>www.heise.de/newsticker/data/jk-19.08.03-000/imh0.jpg
> >>
> >>   What is the  language on  "System V" code  ?   ;-)
> >
> >English using a Greek font.
> >
> >Gr{oetje,eeting}s,
> >					Geert (\Gamma\epsilon\epsilon\rho\tau)
>
> The font is not any Greek font. It is the M$ 'Symbol' one. Other fonts
> would not have this effect at all.
>
> It seems that the misplaced font is the result of much tampering ;) .
> Moreover, this could mostly happen in a M$ machine. Some comment on SCO
> about this ?

Since greek characters are easy for me to read here is said conversion since 
people are curious:

As part of the kernel evolution towards modular naming, the
functions malloc and mfree are being renamed to pmalloc and pmfree
Compatibility will be maintained by the following assembler code:
(also see mfree/pmfree below)

