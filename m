Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267249AbUBSNN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUBSNN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:13:26 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:49097 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S267249AbUBSNNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:13:20 -0500
Date: Thu, 19 Feb 2004 14:13:17 +0100
From: David Weinehall <tao@acc.umu.se>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.6.3-uc0 (MMU-less fixups)
Message-ID: <20040219131317.GI17140@khan.acc.umu.se>
Mail-Followup-To: Greg Ungerer <gerg@snapgear.com>,
	linux-kernel@vger.kernel.org
References: <40342BD5.9080105@snapgear.com> <20040219103900.GH17140@khan.acc.umu.se> <4034B2E5.1090505@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4034B2E5.1090505@snapgear.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 10:58:13PM +1000, Greg Ungerer wrote:
> Hi David,
> 
> David Weinehall wrote:
> >On Thu, Feb 19, 2004 at 01:21:57PM +1000, Greg Ungerer wrote:
> >>An update of the uClinux (MMU-less) fixups against 2.6.3.
> >>Nothing much new, just redone against 2.6.3.
> >>
> >>http://www.uclinux.org/pub/uClinux/uClinux-2.6.x/linux-2.6.3-uc0.patch.gz
> >
> >Any plans for a 2.6-version of the ARM-support?
> 
> Yes. There is some code available now, although it is not complete
> and doesn't fully work yet. It really needs more cleaning up before
> it will be interresting or useful to anyone.

Dang.  I wish I still had some arm-hardware to play with (no, I'm not
gonna sacrifice my Tungsten E for uClinux-work...)

How's the status of the 2.0-port of uClinux, btw?  Is it unintrusive
enough to be considered for a 2.0-merge?


/David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
