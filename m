Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSKMOcb>; Wed, 13 Nov 2002 09:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSKMOcb>; Wed, 13 Nov 2002 09:32:31 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:43426 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261669AbSKMOca>;
	Wed, 13 Nov 2002 09:32:30 -0500
Date: Wed, 13 Nov 2002 14:38:05 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Super I/O chip drivers?
Message-ID: <20021113143805.GA6319@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <15826.24494.889156.510978@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15826.24494.889156.510978@kim.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 03:20:30PM +0100, Mikael Pettersson wrote:
 > I seem to recall that someone was doing drivers for
 > common Super I/O chips. Does anybody have any pointers
 > to this stuff?

http://www.devdrv.com/shsmod/
http://www.devdrv.co.jp/shsmod/shsmod17a-linux.tar.gz

Note that there are definitly problems with this stuff on
some chipsets. Last time I tried it some really bizarre
things started happening to the system clock
(Like jumping back and forth 6 hours every 30 seconds)
Amusing though.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
