Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288728AbSADTpw>; Fri, 4 Jan 2002 14:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSADTpn>; Fri, 4 Jan 2002 14:45:43 -0500
Received: from ns.suse.de ([213.95.15.193]:21005 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288728AbSADTpi>;
	Fri, 4 Jan 2002 14:45:38 -0500
Date: Fri, 4 Jan 2002 20:45:37 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104140538.A19746@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201042044390.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Eric S. Raymond wrote:

> 2. Develop an exception list of mobos that have ISA slots that don't
>    show up under DMI.

You forgot "And show the ISA questions for non-DMI aware PCI systems (that
*might* have ISA)"

> This would be a kluge, but it would have the advantage that the
> exception list is finite and can be expected to stop growing.

I find your faith in BIOS developers amusing. 8)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

