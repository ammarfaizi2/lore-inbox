Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282102AbRKWJ6h>; Fri, 23 Nov 2001 04:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282101AbRKWJ6R>; Fri, 23 Nov 2001 04:58:17 -0500
Received: from ppp-RAS1-1-103.dialup.eol.ca ([64.56.224.103]:23559 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S282098AbRKWJ6M>; Fri, 23 Nov 2001 04:58:12 -0500
Date: Fri, 23 Nov 2001 04:56:58 -0500
From: William Park <opengeometry@yahoo.ca>
To: =?euc-kr?Q?Christian_Borntr=E4ger?= <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PC-133 RAM + VIA 686B -> 4 x DIMM or 3 x DIMM ?
Message-ID: <20011123045658.A3170@node0.opengeometry.ca>
Mail-Followup-To: =?euc-kr?Q?Christian_Borntr=E4ger?= <linux-kernel@borntraeger.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011123043303.A3043@node0.opengeometry.ca> <E167CsI-0004Xg-00@mrvdom03.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E167CsI-0004Xg-00@mrvdom03.schlund.de>; from linux-kernel@borntraeger.net on Fri, Nov 23, 2001 at 10:43:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 10:43:20AM +0100, Christian Bornträger wrote:
> > I'm confused by conflicting rumors about VIA 686B chipset:
> >     - some people can get only 3 x DIMM working at PC-133.
> >     - others report that all 4 x DIMM are working at PC-133.
> 
> First of all: 
> This is offtopic for the ___linux kernel___ mailing list.

I tried *.abit, *.asus, *.tyan, *.linux.hardware newsgroups, but got
nowhere.  This was my last resort.

> 
> Nevertheless:
> VIA686B is the southbridge and has no memory controller.
> The VIA694X-northbridge has 6 memory banks.
> 
> if the 3rd and 4th module are single sided its ok. 
> If the 3rd module is double sided you cannot plugin a 4th module.

Thanks!

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>.
8 CPU cluster, NAS, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Tin
