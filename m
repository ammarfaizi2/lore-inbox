Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283603AbRLIQpF>; Sun, 9 Dec 2001 11:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283610AbRLIQo4>; Sun, 9 Dec 2001 11:44:56 -0500
Received: from ns.caldera.de ([212.34.180.1]:34453 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S283603AbRLIQoj>;
	Sun, 9 Dec 2001 11:44:39 -0500
Date: Sun, 9 Dec 2001 17:42:50 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        linux-ia64@linuxia64.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Re: Linux 2.4.17-pre6 drm-4.0
Message-ID: <20011209174250.A7406@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	linux-ia64@linuxia64.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011208133156.A22531@caldera.de> <E16CjUs-0001ky-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16CjUs-0001ky-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 08, 2001 at 03:34:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 03:34:38PM +0000, Alan Cox wrote:
> > So what DRM can build out of tree easily - e.g. the Caldera LTP
> > (3.1 early access) had a DRM package built completly out of tree.
> 
> XFree86 4.0, 4.1, ... ship with the DRM kernel modules buildable from
> the XFree86 tree too

Been there, done that.

Having seen the XFree build process this doesn't look like an option to
me anymore.  Also a separate tarball easyfies building a new set of modules
for a new kernel a lot.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
