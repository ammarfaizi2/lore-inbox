Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129418AbRBSKyD>; Mon, 19 Feb 2001 05:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129490AbRBSKxx>; Mon, 19 Feb 2001 05:53:53 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:9222 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129418AbRBSKxl>;
	Mon, 19 Feb 2001 05:53:41 -0500
Date: Mon, 19 Feb 2001 11:53:14 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
Message-ID: <20010219115314.A6724@almesberger.net>
In-Reply-To: <5.0.0.25.0.20010216170349.01efc030@mail.etinc.com>, <E14TtEx-0004Lr-00@the-village.bc.nu> <96lrau$dcd$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96lrau$dcd$1@forge.intermeta.de>; from hps@tanstaafl.de on Sat, Feb 17, 2001 at 12:37:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen wrote:
> Company wants to make at least some bucks with their
> products and the driver is part of the product. So they may want to
> release a driver which is "closed source".

Usually, the driver doesn't play a large role in product differentiation,
at least not in a positive way. Also, we must balance the value
closed-sourcing the driver may have for a company, against the damage
this does to Linux development.

Now what's at stake ? Look at the Windows world. Also there, companies
could release their drivers as Open Source. Quick, how many do this ?
Almost none. So, given the choice, most companies have defaulted to
closed source. Consistently complaining when a company tries to release
only closed source drivers for Linux seems to generally have the desired
effect of making them change their policy.

So if we'd follow your line of reasoning, we'd end up with almost all
drivers being closed-source. Since drivers are an essential part of any
Linux kernel, this would essentially mean that all of the Linux kernel
would be subjected to the constraints of closed-source development.

Fine. So you've reinvented AIX, HP-UX, SCO, etc. The question is what
you expect from Linux. After all, you strongly disagree with the main
common denominator of Linux developers, that it be Open Source.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
