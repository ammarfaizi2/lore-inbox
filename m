Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132709AbRDJQoh>; Tue, 10 Apr 2001 12:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRDJQo1>; Tue, 10 Apr 2001 12:44:27 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:38672 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132434AbRDJQoY>;
	Tue, 10 Apr 2001 12:44:24 -0400
Date: Tue, 10 Apr 2001 12:44:49 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Garbage-collection patches for Configure.help
Message-ID: <20010410124449.A32432@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
	axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104101453.f3AErkq30339@snark.thyrsus.com> <E14n10q-0004Yq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14n10q-0004Yq-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 05:29:01PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> Im currently working on getting the arch stuff ready to merge with Linus and
> this patch will just make it a nightmare.

I withdraw it, then.  Would you please do the renames in your patch?  
Those ought to go in, at least.

CONFIG_ARCH_EBSA285				CONFIG_ARCH_EBSA285_HOST
CONFIG_ISDN_DRV_EICON_STANDALONE		CONFIG_ISDN_DRV_EICON_DIVAS
CONFIG_MAC_KEYBOARD				CONFIG_ADB_KEYBOARD

The duplicate-removal stuff in my second patch ought to still be good, also.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The right to buy weapons is the right to be free.
        -- A.E. Van Vogt, "The Weapon Shops Of Isher", ASF December 1942
