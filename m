Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283343AbRLDTzV>; Tue, 4 Dec 2001 14:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283380AbRLDTyF>; Tue, 4 Dec 2001 14:54:05 -0500
Received: from ns.suse.de ([213.95.15.193]:43538 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283377AbRLDTxQ>;
	Tue, 4 Dec 2001 14:53:16 -0500
Date: Tue, 4 Dec 2001 20:53:11 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: David Weinehall <tao@acc.umu.se>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        <kbuild-devel@lists.sourceforge.net>, <torvalds@transmeta.com>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <20011204204822.H360@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.33.0112042051590.7110-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, David Weinehall wrote:

> "So anyone happy with an older distro that didn't ship gcc-2.95.x, x > 2
> gets screwed when they want to build a newer kernel. Nice."

The difference being that recommended compiler versions don't
change midway through a stable series. Neither should any other
part of the buildtools.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

