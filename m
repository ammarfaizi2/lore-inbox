Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132773AbRDDIso>; Wed, 4 Apr 2001 04:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRDDIse>; Wed, 4 Apr 2001 04:48:34 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:48652 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132773AbRDDIsb>;
	Wed, 4 Apr 2001 04:48:31 -0400
Date: Wed, 4 Apr 2001 10:47:02 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010404104702.A23079@pcep-jamie.cern.ch>
In-Reply-To: <E14kPoq-0007w5-00@the-village.bc.nu> <m1lmphw1bi.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1lmphw1bi.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Apr 04, 2001 at 01:50:41AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> I don't know if it applies to this case but one thing I have seen make
> a noticeable difference is whether or not write-combining is enabled.
> If we have only be enabling MTRR's for intel this could do account
> for it.

And on some laptops, even on Intel MTRRs are not enabled for 2.5M
framebuffers.

-- Jamie
