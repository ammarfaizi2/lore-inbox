Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280984AbRL3RO6>; Sun, 30 Dec 2001 12:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbRL3ROj>; Sun, 30 Dec 2001 12:14:39 -0500
Received: from t2.redhat.com ([199.183.24.243]:240 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280537AbRL3ROi>; Sun, 30 Dec 2001 12:14:38 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> 
In-Reply-To: <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net>  <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com> 
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Dec 2001 17:14:22 +0000
Message-ID: <28305.1009732462@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


trini@kernel.crashing.org said:
> > unless (ISA or PCI) suppress dependent IDE

> Just a minor point, but what about non-PCI/ISA ide?

Eric is merely representing the _existing_ rules. Changing the behaviour 
can come later - that shouldn't be done at the same time as introducing CML2.

--
dwmw2


