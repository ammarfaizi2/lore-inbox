Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbSJBAsZ>; Tue, 1 Oct 2002 20:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262311AbSJBAsZ>; Tue, 1 Oct 2002 20:48:25 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:22519 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262081AbSJBAsX>; Tue, 1 Oct 2002 20:48:23 -0400
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20021001184225.GC29788@marowsky-bree.de>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu>
	<Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it>
	<20021001154808.GD126@suse.de>  <20021001184225.GC29788@marowsky-bree.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 02:00:58 +0100
Message-Id: <1033520458.20284.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-01 at 19:42, Lars Marowsky-Bree wrote:
> I'll again pipe in for the radical solution: EVMS(powerful) on top of
> device-mapper(elegant). 

The more shit you pile the more likely your compost heap is to collapse.
And with some of the stuff in EVMS I don't want to be around when it
does

> EVMS also shows promise as they are working on _open_ cluster support, which I
> think will be one of the big things to happen in 2.7. 

DM is small and clean. It may well be that if we go the DM way (and I
think we should) that those bits of EVMS that we want (like cluster)
actually come out a lot cleaner than in EVMS itself

Alan

