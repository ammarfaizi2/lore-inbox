Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRLHMd4>; Sat, 8 Dec 2001 07:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279317AbRLHMdq>; Sat, 8 Dec 2001 07:33:46 -0500
Received: from ns.caldera.de ([212.34.180.1]:32909 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S279261AbRLHMdg>;
	Sat, 8 Dec 2001 07:33:36 -0500
Date: Sat, 8 Dec 2001 13:31:56 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, linux-ia64@linuxia64.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Re: Linux 2.4.17-pre6 drm-4.0
Message-ID: <20011208133156.A22531@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	linux-ia64@linuxia64.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4494.1007767210@ocs3.intra.ocs.com.au> <E16Cflf-00019F-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Cflf-00019F-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 08, 2001 at 11:35:43AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 11:35:43AM +0000, Alan Cox wrote:
> > to get rid of them asap.  The SiS direct render is only for drm 4.1 so
> > now is a good time to question if 4.0 is still required.
> 
> That argument doesnt fly. The 4.0 DRM is the only working GMX renderer..

So what DRM can build out of tree easily - e.g. the Caldera LTP
(3.1 early access) had a DRM package built completly out of tree.

David, would you remove drm-4.0 from the ia64 patch if I'd do the work
again and package an up-to-date and ia64-capable drm 4.0 out-of-tree?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
