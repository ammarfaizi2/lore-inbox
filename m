Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291794AbSBXXJd>; Sun, 24 Feb 2002 18:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSBXXJY>; Sun, 24 Feb 2002 18:09:24 -0500
Received: from tapu.f00f.org ([66.60.186.129]:5250 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S291780AbSBXXJK>;
	Sun, 24 Feb 2002 18:09:10 -0500
Date: Sun, 24 Feb 2002 15:08:56 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Paul Mackerras <paulus@samba.org>, Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224230856.GB15280@tapu.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net> <20020224215422.B1706@ucw.cz> <20020224151923.E1682@altus.drgw.net> <20020224223759.C1814@ucw.cz> <15481.25374.253992.643727@argo.ozlabs.ibm.com> <20020224230855.A2199@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224230855.A2199@ucw.cz>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 11:08:55PM +0100, Vojtech Pavlik wrote:

    And running PCI over 33 MHz isn't legal in the PCI spec as far as I
    know. You can go lower, but I think the limit is 16 MHz there.

_ALL_ PCI 2.x cards must work at at least 33 Mhz, some way work
higher. _ALL_ must work lower speeds too (for example a power saving
measures might be dropping the PCI bus speed).



  --cw
