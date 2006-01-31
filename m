Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWAaNe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWAaNe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWAaNe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:34:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28358 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750812AbWAaNe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:34:27 -0500
Subject: Re: [CVE-2005-4639] Re: [PATCH 2.6.14] dvb: dst: Fix possible
	buffer overflow
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: security@kernel.org
Cc: Kerin Millar <kerframil@gmail.com>, stable@kernel.org, manu@linuxtv.org,
       dsd@gentoo.org, plasmaroo@gentoo.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>,
       security@kernel.org, Andrew Morton <akpm@osdl.org>,
       Manu Abraham <abraham.manu@gmail.com>
In-Reply-To: <43DF4F8A.6090705@gmail.com>
References: <279fbba40601301556g6aeae646i@mail.gmail.com>
	 <43DF4F8A.6090705@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 31 Jan 2006 11:33:09 -0200
Message-Id: <1138714389.810.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2006-01-31 às 15:52 +0400, Manu Abraham escreveu:
> Kerin Millar wrote:
> > Hi,
> >
> > please consider this fix for 2.6.14.7. It's a security fix for
> > CVE-2005-4639. If it's too late then please queue for the next release
> > if applicable.
We are already at 2.6.15. I'm not sure if security guys are willing to
accept it for 2.6.14, but, if possible, it have my agreement.
> >
> > Thanks,
> >
> > --Kerin
> >
> > PS: a few of the recipients may have received a copy without the
> > attachment. Apologies for the noise in that case.
> >   
> 
> Acked-by: Manu Abraham <manu@linuxtv.org>
Acked-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> 
> 
> Manu
> 
Cheers, 
Mauro.

