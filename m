Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbSJBWct>; Wed, 2 Oct 2002 18:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262661AbSJBWct>; Wed, 2 Oct 2002 18:32:49 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:20974 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262659AbSJBWcp>; Wed, 2 Oct 2002 18:32:45 -0400
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021002222958.GN1202@marowsky-bree.de>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu>
	<Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it>
	<20021001154808.GD126@suse.de> <20021001184225.GC29788@marowsky-bree.de>
	<1033520458.20284.46.camel@irongate.swansea.linux.org.uk>
	<20021002042434.GA13971@think.thunk.org>
	<1033565669.23682.10.camel@irongate.swansea.linux.org.uk>
	<20021002145434.GA1202@marowsky-bree.de>
	<1033578571.23758.32.camel@irongate.swansea.linux.org.uk> 
	<20021002222958.GN1202@marowsky-bree.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 23:46:00 +0100
Message-Id: <1033598760.25240.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 23:29, Lars Marowsky-Bree wrote:
> Sounds like a good reason to do the cleanup immediately, then.
> Deleting code, I can do that ;-)

Absolutely - taking the core EVMS(say the core code and the bits to do
LVM1) and polishing them up to be good clean citizens without code
duplication and other weirdness would be a superb start for EVMS as a
merge candidate. The rest can follow a piece at a time once the core is
right if EVMS is the right path

