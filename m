Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284467AbRLRSlq>; Tue, 18 Dec 2001 13:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbRLRSkY>; Tue, 18 Dec 2001 13:40:24 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:20462 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284491AbRLRSis>; Tue, 18 Dec 2001 13:38:48 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181535.fBIFZEH16236@pinkpanther.swansea.linux.org.uk>
Subject: Re: 2.4.17-rc1 does not boot my Alphas
To: michal@harddata.com (Michal Jaegermann)
Date: Tue, 18 Dec 2001 15:35:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011216160404.A2945@mail.harddata.com> from "Michal Jaegermann" at Dec 16, 2001 04:04:04 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A kernel with the highest version which I managed to boot so far,
> on both machines, is 2.4.13-ac8.  Anybody with a handly on what is
> going on?  I did not check yet if various Alpha specific patches
> which were present in "ac" were merged into mainline.  But so
> far things seem to be quite thorougly broken for Alpha (or at
> least Nautilus).

Those and more went into 2.4.16+ so I believe that its probably a new 
breakage not a lost diff

