Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132241AbRA3Sz2>; Tue, 30 Jan 2001 13:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132249AbRA3SzS>; Tue, 30 Jan 2001 13:55:18 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:33267
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S132241AbRA3SzA>; Tue, 30 Jan 2001 13:55:00 -0500
Date: Tue, 30 Jan 2001 11:53:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Micha? 'CeFeK' Nazarewicz" <CeFeK@MichalNazarewicz.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: 2.4.1 - ppc - compile problems
Message-ID: <20010130115319.G17512@opus.bloom.county>
In-Reply-To: <NEBBIOGJMKPNNALEPMFGMEJACCAA.CeFeK@MichalNazarewicz.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <NEBBIOGJMKPNNALEPMFGMEJACCAA.CeFeK@MichalNazarewicz.COM>; from CeFeK@MichalNazarewicz.COM on Sun, Jan 28, 2001 at 03:32:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2001 at 03:32:33PM +0100, Micha? 'CeFeK' Nazarewicz wrote:

> There appears to be undefined variable (in pmac_pci), called
> PCI_DEVICE_ID_APPLE_KL_USB. When anyone tries to compile the newest kernel
> on PPC machine with USB support on, there is an error saying that this is
> undefined.

2.4.x from kernel.org currently does not work on PPC.  Take a look at:
http://www.fsmlabs.com/linuxppcbk.html

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
