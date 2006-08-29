Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965153AbWH2Q7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbWH2Q7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWH2Q7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:59:51 -0400
Received: from witte.sonytel.be ([80.88.33.193]:63124 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965122AbWH2Q7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:59:49 -0400
Date: Tue, 29 Aug 2006 18:58:45 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: David Howells <dhowells@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <20060829165352.GA20453@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0608291858300.3907@pademelon.sonytel.be>
References: <20060829162055.GA31159@linux-mips.org> <44F395DE.10804@yahoo.com.au>
 <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0608290855510.18031@schroedinger.engr.sgi.com>
 <5878.1156868702@warthog.cambridge.redhat.com> <20060829165352.GA20453@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006, Ralf Baechle wrote:
> On Tue, Aug 29, 2006 at 05:25:02PM +0100, David Howells wrote:
> 
> > Some of these have LL/SC or equivalent instead, but ARM5 and before, FRV, M68K
> > before 68020 to name but a few.
> 
> 68k before 68020 isn't supported by Linux anyway.

uClinux anyone?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
