Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUCFLJE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 06:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUCFLJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 06:09:04 -0500
Received: from AGrenoble-101-1-4-31.w217-128.abo.wanadoo.fr ([217.128.202.31]:55270
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S261640AbUCFLJC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 06:09:02 -0500
Subject: Re: [PATCH] UTF-8ifying the kernel source
From: Xavier Bestel <xavier.bestel@free.fr>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <c2b2o0$cbp$1@terminus.zytor.com>
References: <20040304100503.GA13970@havoc.gtf.org>
	 <20040305232425.GA6239@havoc.gtf.org>  <c2b2o0$cbp$1@terminus.zytor.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1078571331.963.3.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 12:08:52 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 06/03/2004 à 00:33, H. Peter Anvin a écrit :
> Followup to:  <20040305232425.GA6239@havoc.gtf.org>
> By author:    David Eger <eger@havoc.gtf.org>
> In newsgroup: linux.dev.kernel
> 
> > The third patch concerns 8-bit characters embedded in C strings.
> > These are almost always output to devfs or proc.  The characters used are
> > the degrees symbol (for ppc temp. sensors) and mu (for micro-seconds).
>
> I would highly vote for making those UTF-8 unless it breaks protocol.

ISO-8859-1 characters are mostly the same in UTF-8.

	Xav

