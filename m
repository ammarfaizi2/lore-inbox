Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266570AbSKGOqp>; Thu, 7 Nov 2002 09:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266574AbSKGOqp>; Thu, 7 Nov 2002 09:46:45 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:48074 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266570AbSKGOqo>;
	Thu, 7 Nov 2002 09:46:44 -0500
Date: Thu, 7 Nov 2002 14:51:12 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021107145112.GA24278@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036415133.1106.10.camel@irongate.swansea.linux.org.uk> <20021104025458.GA3088@zip.com.au> <9668.1036679581@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9668.1036679581@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 02:33:01PM +0000, David Woodhouse wrote:

 > We should really have an extra taint flag for 'We have run untrusted BIOS 
 > code'. 

Relatively pointless given that there are more and more boxes out there
that won't boot without ACPI these days.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
