Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSKGPlE>; Thu, 7 Nov 2002 10:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSKGPlE>; Thu, 7 Nov 2002 10:41:04 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:16331 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261296AbSKGPlD>;
	Thu, 7 Nov 2002 10:41:03 -0500
Date: Thu, 7 Nov 2002 15:46:09 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021107154609.GB25903@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021107145112.GA24278@suse.de> <1036415133.1106.10.camel@irongate.swansea.linux.org.uk> <20021104025458.GA3088@zip.com.au> <9668.1036679581@passion.cambridge.redhat.com> <11262.1036680930@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11262.1036680930@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 02:55:30PM +0000, David Woodhouse wrote:

 > There are also more and more boxes out there which won't run X without the
 > nvidia driver loaded.

Crap. The OSS driver works fine, just not as accelerated.
 
 > I'm not necessarily suggesting we should automatically ignore all reports 
 > with the 'BIOS' taint flag set as we do the 'Proprietary' flag; just that 
 > it should be reported.

I don't see what it would buy us.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
