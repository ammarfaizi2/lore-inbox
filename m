Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281214AbRL3Rdd>; Sun, 30 Dec 2001 12:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281663AbRL3RdW>; Sun, 30 Dec 2001 12:33:22 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:57524
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S281214AbRL3RdT>; Sun, 30 Dec 2001 12:33:19 -0500
Date: Sun, 30 Dec 2001 10:32:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011230173258.GA28513@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com> <28305.1009732462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28305.1009732462@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 05:14:22PM +0000, David Woodhouse wrote:
> 
> trini@kernel.crashing.org said:
> > > unless (ISA or PCI) suppress dependent IDE
> 
> > Just a minor point, but what about non-PCI/ISA ide?
> 
> Eric is merely representing the _existing_ rules. Changing the behaviour 
> can come later - that shouldn't be done at the same time as introducing CML2.

Yes, but what I was getting at was that these constraints will change
(either because they were incorrect or no longer aplicable).

Either way, why not fix bugs now? (since there are non-PCI/ISA ide,
which is why I kept that example to start with).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
