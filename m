Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbSLWPU4>; Mon, 23 Dec 2002 10:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbSLWPUz>; Mon, 23 Dec 2002 10:20:55 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52653 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266712AbSLWPUy>;
	Mon, 23 Dec 2002 10:20:54 -0500
Date: Mon, 23 Dec 2002 15:28:12 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Re: NMI: IOCK error (debug interrupt?) - nope
Message-ID: <20021223152812.GA7773@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Gianni Tedesco <gianni@ecsc.co.uk>, linux-kernel@vger.kernel.org
References: <1040293420.12106.13.camel@lemsip> <1040656341.23373.18.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040656341.23373.18.camel@lemsip>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 03:12:22PM +0000, Gianni Tedesco wrote:
 > > When we looked in the logs there was this. Presumably the hardware is
 > > broken. But I wonder if anyone can confirm this? Thanks!
 > > 
 > > NMI: IOCK error (debug interrupt?)
 > 
 > Turns out to be a 2bit ECC error. The machine is a dell power-edge 350.

A while ago I mentioned it would be nice to get the ECC drivers
cleaned up and included. Any yays or nays to getting this stuff
done sometime ?

Yes it's a feature, but it's also just extra drivers.
Decisions decisions...

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
