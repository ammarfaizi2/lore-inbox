Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269912AbUIDMLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269912AbUIDMLV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUIDMLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:11:21 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:458 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269912AbUIDMLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:11:19 -0400
Date: Sat, 4 Sep 2004 13:10:39 +0100
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904121039.GB26419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>,
	Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904124658.A14628@infradead.org> <Pine.LNX.4.58.0409041253390.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041253390.25475@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 01:04:17PM +0100, Dave Airlie wrote:

 > releases, I would like to give those people a chance to use their graphics
 > cards, and the snapshots are not the only way, Intel have i915 Linux
 > drivers on their site from TG, they work on most kernels/distros, I get a
 > machine with i915 install Debian go to Intels website and download their
 > drivers, it all works, now why do I have to compile a kernel again?

Then a month later, Debian issues a kernel security errata.
You download and install it, and your 3d stops working.
(worse case, maybe even your 2d breaks).
The 'download third party drivers' thing is not a silver bullet.
It will screw end users over, just as equally as it claims to help them.

		Dave

