Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRD2Tig>; Sun, 29 Apr 2001 15:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136045AbRD2Ti0>; Sun, 29 Apr 2001 15:38:26 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:56069 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131407AbRD2TiM>;
	Sun, 29 Apr 2001 15:38:12 -0400
Date: Sun, 29 Apr 2001 21:38:04 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Message-ID: <20010429213804.D8512@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com> <3AEBF782.1911EDD2@mandrakesoft.com> <15083.64180.314190.500961@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15083.64180.314190.500961@pizda.ninka.net>; from davem@redhat.com on Sun, Apr 29, 2001 at 04:27:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> It's particularly attractive on sparc64 because you
> can use a "global" TLB entry which is thus shared between all address
> spaces.

Fwiw, modern x86 has global TLB entries too.

-- Jamie
