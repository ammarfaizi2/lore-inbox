Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRL3Rpc>; Sun, 30 Dec 2001 12:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRL3RpW>; Sun, 30 Dec 2001 12:45:22 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:33810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281797AbRL3RpI>; Sun, 30 Dec 2001 12:45:08 -0500
Date: Sun, 30 Dec 2001 17:44:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Tom Rini <trini@kernel.crashing.org>, "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011230174437.D9625@flint.arm.linux.org.uk>
In-Reply-To: <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com> <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> <28305.1009732462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <28305.1009732462@redhat.com>; from dwmw2@infradead.org on Sun, Dec 30, 2001 at 05:14:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 05:14:22PM +0000, David Woodhouse wrote:
> trini@kernel.crashing.org said:
> > > unless (ISA or PCI) suppress dependent IDE
> 
> > Just a minor point, but what about non-PCI/ISA ide?
> 
> Eric is merely representing the _existing_ rules. Changing the behaviour 
> can come later - that shouldn't be done at the same time as introducing CML2.

Existing rules allow non-PCI/ISA IDE.  Its a bug, not a change of
behaviour.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

